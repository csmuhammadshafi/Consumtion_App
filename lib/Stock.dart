import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Product  Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Vendor Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Description',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Price',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Total',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Payment Paid',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Payment Remaining ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 120.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Date-time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Strock Entry'),
                  content: Container(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Product Name',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Vendor Name'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Description'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Quantity'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment Paid'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Remaining'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status'),
                              Container(
                                width: 130,
                                child: TextFormField(
                                  decoration: InputDecoration(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
