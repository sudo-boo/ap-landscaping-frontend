import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/pages/customer/create_order_success_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BillingPage extends StatefulWidget {
  final token;
  final customerId;
  final orderInfo order_info;
  const BillingPage(
      {Key? key, this.token, this.customerId, required this.order_info})
      : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  void create_Order() async {
    var orderBody = {
      "serviceType": widget.order_info.serviceType,
      "address": widget.order_info.address,
      "date": widget.order_info.date,
      "time": widget.order_info.time,
      "expectationNote": widget.order_info.expectationNote,
      "customerId": widget.order_info.customerId,
    };
    var response = await http.post(Uri.parse(createOrder),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: jsonEncode(orderBody));
    if (response.statusCode == 201) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CongratsPage(
                  token: widget.token, customerId: widget.customerId)));
    } else {
      print(response.statusCode);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              // content: Text(err.message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // title: Text(widget.serviceName),
          title: const Text(
            'Book Services',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // backgroundColor: Colors.green[900],
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // const SizedBox(height: 690),
                Center(
                  child: Container(
                    width: 217,
                    height: 69,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 0,
                          top: 53,
                          child: Text(
                            'Step1',
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 172,
                          top: 53,
                          child: Text(
                            'Step 2',
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 1,
                          top: 0,
                          child: Container(
                            width: 212,
                            height: 37,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 37,
                                            height: 37,
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: OvalBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFA686FF)),
                                              ),
                                            ),
                                            child: const Image(
                                              image: AssetImage(
                                                  'lib/assets/images/tickMarkIcon.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 55,
                                  top: 18.50,
                                  child: Container(
                                    width: 100,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.50,
                                          strokeAlign:
                                          BorderSide.strokeAlignCenter,
                                          color: Color(0xFF3E363F),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 175,
                                  top: 0,
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 37,
                                            height: 37,
                                            decoration: const ShapeDecoration(
                                              color: Color(0xFFA686FF),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          left: 10,
                                          top: 10,
                                          child: Text(
                                            '02',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900]),
                        child: const Text(
                          'Cancel Order ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          create_Order();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900]),
                        child: const Text(
                          'Confirm Order',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
