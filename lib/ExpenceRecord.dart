import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenceRecord extends StatefulWidget {
  const ExpenceRecord({super.key});

  @override
  State<ExpenceRecord> createState() => _ExpenceRecordState();
}

class _ExpenceRecordState extends State<ExpenceRecord> {
  final firestore = FirebaseFirestore.instance.collection('expence').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('Title'),
                      _buildHeaderCell('Acc Name'),
                      _buildHeaderCell('Amount'),
                      _buildHeaderCell('Description'),
                      _buildHeaderCell('Date'),
                      _buildHeaderCell('Action'), // Added Action header
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: firestore,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final data = snapshot.data?.docs ?? [];
                      return Column(
                        children: data.map((doc) {
                          final record = doc.data() as Map<String, dynamic>;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDataCell(statusValue(record['status'])),
                              _buildDataCell(record['title']),
                              _buildDataCell(record['acc']),
                              _buildDataCell(record['amount']),
                              _buildDataCell(record['desc']),
                              _buildDataCell(record['date']),
                              _buildActionCell(doc.id, record), // Added Action cell
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      width: 120.w,
      height: 50.h,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildDataCell(String? text) {
    return Container(
      width: 120.w,
      height: 50.h,
      child: Center(
        child: Text(
          text ?? '',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildActionCell(String docId, Map<String, dynamic> record) {
    return Container(
      width: 120.w,
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editRecord(docId, record);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteRecord(docId);
            },
          ),
        ],
      ),
    );
  }

  String statusValue(bool? status) {
    if (status == true) {
      return "In";
    } else {
      return "Out";
    }
  }

  Future<void> _editRecord(String docId, Map<String, dynamic> record) async {
    await _showEditDialog(docId, record);
  }

  Future<void> _showEditDialog(String docId, Map<String, dynamic> record) async {
    TextEditingController titleController = TextEditingController(text: record['title']);
    TextEditingController accController = TextEditingController(text: record['acc']);
    TextEditingController amountController = TextEditingController(text: record['amount']);
    TextEditingController descController = TextEditingController(text: record['desc']);
    TextEditingController dateController = TextEditingController(text: record['date']);
    bool status = record['status'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Record'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: accController,
                  decoration: InputDecoration(labelText: 'Acc Name'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateRecord(
                  docId,
                  titleController.text,
                  accController.text,
                  amountController.text,
                  descController.text,
                  dateController.text,
                  status,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateRecord(String docId, String title, String acc, String amount, String desc, String date, bool status) async {
    await FirebaseFirestore.instance.collection('expence').doc(docId).update({
      'title': title,
      'acc': acc,
      'amount': amount,
      'desc': desc,
      'date': date,
      'status': status,
    });
  }

  Future<void> _deleteRecord(String docId) async {
    await FirebaseFirestore.instance.collection('expence').doc(docId).delete();
  }
}
