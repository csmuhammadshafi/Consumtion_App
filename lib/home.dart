import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:testing_firebase/BalanceRecord.dart';
import 'package:testing_firebase/ExpenceRecord.dart';
import 'package:testing_firebase/Stock.dart';
import 'package:testing_firebase/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

double balance = 0;
double expense = 0;
List today = [];
List<String> Status = [];
List<String> title = [];
List<String> AccName = [];
List<String> Amount = [];
List<String> Description = [];
List<String> Date = [];
DateTime now = DateTime.now();

class _HomeState extends State<Home> {
  addToday() {
    for (int i = 0; i < Status.length; i++) {
      // int count = 0;
      today.add(i);
    }
  }

  Balance() {
    for (int i = 0; i < Status.length; i++) {
      if (Status[i] == 'in' || Status[i] == 'In') {
        balance += double.parse(Amount[i]);
      }
    }
    balance = balance - expense;
  }

  Expense() {
    for (int i = 0; i < Status.length; i++) {
      if (Status[i] == 'out' || Status[i] == 'Out') {
        expense += double.parse(Amount[i]);
      }
    }
  }

  String timeNow() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('dd-MM-yyyy hh:mm a').format(now);
    return formattedTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    today.clear();
    addToday();
    Balance();
    Expense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _title = TextEditingController();
    TextEditingController _AccName = TextEditingController();
    TextEditingController _Amount = TextEditingController();
    TextEditingController _Desc = TextEditingController();
    // TextEditingController _ = TextEditingController();
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    Stream<QuerySnapshot> firestore =
        FirebaseFirestore.instance.collection("balance").snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consumption App',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Balancerecord(
                                    // status: Status,
                                    // title: title,
                                    // accName: AccName,
                                    // Amount: Amount,
                                    // Desc: Description,
                                    // date: Date,
                                    )));
                      },
                      child: Card(
                        // shape: RoundedRectangleBorder(),
                        color: Colors.deepOrangeAccent.shade100,
                        elevation: 7,
                        child: Container(
                          height: 180.h,
                          width: 180.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    // color: Colors.grey.shade700.withOpacity(.7)
                                    color:
                                        Colors.grey.shade800.withOpacity(.9)),
                              ),
                              Text(
                                '\$$balance',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Colors.grey.shade700.withOpacity(.7)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Records(
                        //               status: Status,
                        //               title: title,
                        //               accName: AccName,
                        //               Amount: Amount,
                        //               Desc: Description,
                        //               date: Date,
                        //             )));
                      },
                      child: GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>ExpenceRecord()));},
                        child: Card(
                          color: Colors.deepOrangeAccent.shade100,
                          elevation: 7,
                          child: Container(
                            height: 180.h,
                            width: 180.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Colors.grey.shade800.withOpacity(.9)),
                                ),
                                Text(
                                  '\$$expense',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Colors.grey.shade700.withOpacity(.7)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 170.w,
                          // color: Colors.amber,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Add amount'),
                                          content: Container(
                                            // color: Colors.amber,
                                            height: 260,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Title ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                          controller: _title,
                                                          style: TextStyle(
                                                              fontSize: 18.sp),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Acc Name ',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                          )),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                            controller:
                                                                _AccName,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Amount ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller: _Amount,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 80.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Description ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 60.h,
                                                        child: TextField(
                                                            maxLength: 10,
                                                            controller: _Desc,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  // setState(() {
                                                  //   Status.add('In');
                                                  //   title.add(_title.text);
                                                  //   AccName.add(_AccName.text);
                                                  //   Amount.add(_Amount.text);
                                                  //   Description.add(_Desc.text);
                                                  //   int date = now.day;
                                                  //   int month = now.month;
                                                  //   int year = now.year;
                                                  //   Date.add(
                                                  //       '$date-$month-$year');
                                                  //   Navigator.pop(context);
                                                  //   FocusNode().unfocus();
                                                  //   balance = 0;
                                                  //   Balance();
                                                  //   today.clear();
                                                  //   addToday();
                                                  // });

                                                  String id = DateTime.now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                                  final db = FirebaseFirestore
                                                      .instance
                                                      .collection("balance")
                                                      .doc(id);
                                                  var data = model(
                                                      id: id,
                                                      title: _title.text,
                                                      acc: _AccName.text,
                                                      amount: _Amount.text,
                                                      desc: _Desc.text,
                                                      date:
                                                          timeNow().toString(),
                                                      status: true);
                                                  final json = data.tojson();

                                                  db.set(json).whenComplete(() {
                                                    _Desc.clear();
                                                    _title.clear();
                                                    _AccName.clear();
                                                    _Amount.clear();
                                                    Fluttertoast.showToast(
                                                        msg: 'Added',
                                                        gravity: ToastGravity
                                                            .BOTTOM);
                                                  }).onError(
                                                    (error, stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg: 'error occured',
                                                          gravity: ToastGravity
                                                              .BOTTOM);
                                                      _Desc.clear();
                                                      _title.clear();
                                                      _AccName.clear();
                                                      _Amount.clear();
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  FocusNode().unfocus();
                                                },
                                                child: Text('Cancel'))
                                          ],
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 41, 178, 50),
                                    size: 40.r,
                                  ),
                                ),
                              ),
                              Text(
                                ' Add Amount',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 180.w,
                          // color: Colors.black,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Add Expenses'),
                                          content: Container(
                                            // color: Colors.amber,
                                            height: 260,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.amber,
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Title ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                          controller: _title,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text('Acc Name ',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                          )),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                            controller:
                                                                _AccName,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Amount ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 40.h,
                                                        child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller: _Amount,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 90.h,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Description ',
                                                        style: TextStyle(
                                                            fontSize: 20.sp),
                                                      ),
                                                      Container(
                                                        width: 140.w,
                                                        height: 60.h,
                                                        child: TextField(
                                                            maxLength: 10,
                                                            controller: _Desc,
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  // if (_Desc.text == '' &&
                                                  //     _Amount.text == '' &&
                                                  //     _AccName.text == '' &&
                                                  //     _title.text == '') {
                                                  // } else {
                                                  //   setState(() {
                                                  //     Status.add('Out');
                                                  //     title.add(_title.text);
                                                  //     AccName.add(
                                                  //         _AccName.text);
                                                  //     Amount.add(_Amount.text);
                                                  //     Description.add(
                                                  //         _Desc.text);
                                                  //     int date = now.day;
                                                  //     int month = now.month;
                                                  //     int year = now.year;
                                                  //     Date.add(
                                                  //         '$date-$month-$year');
                                                  //     Navigator.pop(context);
                                                  //     FocusNode().unfocus();
                                                  //     today.clear();
                                                  //     addToday();
                                                  //     expense = 0;
                                                  //     Expense();
                                                  //     balance = 0;
                                                  //     Balance();
                                                  //   });
                                                  // }

                                                  String id = DateTime.now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                                  final db = FirebaseFirestore
                                                      .instance
                                                      .collection("expence")
                                                      .doc(id);
                                                  var data = model(
                                                      id: id,
                                                      title: _title.text,
                                                      acc: _AccName.text,
                                                      amount: _Amount.text,
                                                      desc: _Desc.text,
                                                      date:
                                                          timeNow().toString(),
                                                      status: false);
                                                  final json = data.tojson();

                                                  db.set(json).whenComplete(() {
                                                    _Desc.clear();
                                                    _title.clear();
                                                    _AccName.clear();
                                                    _Amount.clear();
                                                    Fluttertoast.showToast(
                                                        msg: 'Added',
                                                        gravity: ToastGravity
                                                            .BOTTOM);
                                                  }).onError(
                                                    (error, stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg: 'error occured',
                                                          gravity: ToastGravity
                                                              .BOTTOM);
                                                      _Desc.clear();
                                                      _title.clear();
                                                      _AccName.clear();
                                                      _Amount.clear();
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  FocusNode().unfocus();
                                                },
                                                child: Text('Cancel'))
                                          ],
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.redAccent.shade700,
                                    size: 40.r,
                                  ),
                                ),
                              ),
                              Text(
                                ' Add Expenses',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Stock()));
                  },
                  child: Card(
                      elevation: 7,
                      color: Colors.deepOrangeAccent.shade100,
                      child: Container(
                        width: widthOfScreen * .9,
                        height: heightOfScreen * .15,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'UnPaid Bills: __',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Remaining Balance: __',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Card(
                  elevation: 20,
                  child: Container(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .33,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'status',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'Acc Name',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                                Container(
                                  // color: Colors.black,
                                  width: 120.w,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ],
                            ),
                            // StreamBuilder<QuerySnapshot>(
                            //     stream: firestore,
                            //     builder: (context,
                            //         AsyncSnapshot<QuerySnapshot> snapshot) {
                            //       return  ;
                            //     }),
                            Container(
                                // color: Colors.black,
                                height: heightOfScreen * .255,
                                width: widthOfScreen * 1.9.h,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: firestore,
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    return ListView.builder(
                                        itemCount:
                                            snapshot.data!.docs.length > 5
                                                ? 5
                                                : snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          status_value() {
                                            final status = snapshot
                                                .data!.docs[index]["status"];
                                            String value;
                                            if (status == true)
                                              return "In";
                                            else
                                              return "Out";
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //                     // Container(
                                                //                     //   // color: Colors.black,
                                                //                     //   width: 120.w,
                                                //                     //   height: 50.h,
                                                //                     //   child: Center(
                                                //                     //       child: Status_Column(
                                                //                     //           Index: index)),
                                                //                     // ),

                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                          status_value(),
                                                          style: TextStyle(
                                                              fontSize: 17))),
                                                ),
                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                    snapshot.data!.docs[index]
                                                        ["title"],
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  )),
                                                ),
                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["acc"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 17))),
                                                ),
                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ["amount"],
                                                          style: TextStyle(
                                                              fontSize: 17))),
                                                ),
                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                    snapshot.data!.docs[index]
                                                        ["desc"],
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  )),
                                                ),

                                                Container(
                                                  // color: Colors.black,
                                                  width: 120.w,
                                                  height: 50.h,
                                                  child: Center(
                                                      child: Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ["date"],
                                                          style: TextStyle(
                                                              fontSize: 17))),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
