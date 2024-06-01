import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/pages/customer/create_order_success_page.dart';
import 'package:ap_landscaping/pages/customer/customer_payments_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services_data.dart';
import 'customer_home_page.dart';

class CustomerBillingPage extends StatefulWidget {
  final token;
  final customerId;
  final orderInfo order_info;
  const CustomerBillingPage(
      {Key? key, this.token, this.customerId, required this.order_info})
      : super(key: key);

  @override
  _CustomerBillingPageState createState() => _CustomerBillingPageState();
}

class _CustomerBillingPageState extends State<CustomerBillingPage> {

  Future<void> createOrderFunc(BuildContext context) async {
    var orderBody = {
      "serviceType": widget.order_info.serviceType,
      "address": widget.order_info.address,
      "date": widget.order_info.date,
      "time": widget.order_info.time,
      "expectationNote": widget.order_info.expectationNote,
      "customerId": widget.order_info.customerId,
    };

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents user from dismissing the dialog
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 120,
            width: 120,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Creating Order... Please Wait..!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      var response = await http.post(
        Uri.parse(createOrder),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: jsonEncode(orderBody),
      );

      Navigator.pop(context); // Close the loading dialog

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        print("Order id is : ${responseBody["orderId"]}");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerPaymentsPage(
              token: widget.token,
              customerId: widget.customerId,
              orderID: responseBody["orderId"],
              serviceType: widget.order_info.serviceType,
            ),
          ),
        );
      } else {
        print(response.statusCode);
        showErrorDialog(context, 'Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      Navigator.pop(context); // Close the loading dialog
      showErrorDialog(context, 'An error occurred.');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                image: AssetImage('assets/images/backIcon.png'),
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
                                                  'assets/images/tickMarkIcon.png'),
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
                ),Padding(
                  padding: const EdgeInsets.fromLTRB(5, 16, 5, 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            widget.order_info.serviceType,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Date: \t ${widget.order_info.date}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  'Time: \t ${widget.order_info.time}',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 15),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "Price Details : ",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        subtitle: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFCFF29B),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price: ",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${servicesData.firstWhere((service) => service.containsKey(widget.order_info.serviceType)).values.first['price']}",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Offer: ",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${servicesData.firstWhere((service) => service.containsKey(widget.order_info.serviceType)).values.first['offer']}% off",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount: ",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "\$${servicesData.firstWhere((service) => service.containsKey(widget.order_info.serviceType)).values.first['price']}",
                                    style: TextStyle(
                                      color: Color(0xFF3E363F),
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          createOrderFunc(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50), // Changed color to a more appropriate green
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.payment, // Appropriate icon for payment
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10), // Spacing between icon and text
                                Text(
                                  'Pay Online',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.07,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CustomerHomePage(
                                    token: widget.token,
                                    customerId: widget.customerId
                                )
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.red,
                                width: 2
                              )
                            ),
                            alignment: Alignment.center,
                            child:
                              Text(
                                'Cancel Order',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.07,
                                ),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
