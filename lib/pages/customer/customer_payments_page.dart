import 'dart:async';
import 'dart:convert';
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/pages/customer/create_order_success_page.dart';
import 'package:ap_landscaping/pages/customer/customer_home.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import '../services_data.dart';

class CustomerPaymentsPage extends StatefulWidget {
  final String token;
  final String customerId;
  final String orderID;
  final String serviceType;

  const CustomerPaymentsPage({
    required this.token,
    required this.customerId,
    required this.orderID,
    required this.serviceType,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerPaymentsPage> createState() => _CustomerPaymentsPageState();
}

class _CustomerPaymentsPageState extends State<CustomerPaymentsPage> {
  String sessionId = '';
  String paymentUrl = '';
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    createPayment();
  }

  // Future<void> _launchUrl(String paymenturl) async {
  //   print('Launching payment URL...');
  //   try {
  //     await launch(paymenturl, forceWebView: true, enableJavaScript: true);
  //     print('Payment URL launched successfully. Test Complete');
  //   } catch (e) {
  //     print('Could not launch payment URL: $e');
  //   }
  // }

  void createPayment() async {
    double priceAmount = 0.0;
    for (var service in servicesData) {
      if (service.containsKey(widget.serviceType)) {
        var serviceData = service[widget.serviceType];
        setState(() {
          priceAmount = serviceData["price"];
        });
        break;
      }
    }
    try {
      final response = await http.post(
        Uri.parse(paymentEngage),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: json.encode({
          "orderId": widget.orderID,
          "amount": priceAmount
        }),
      );

      // Print the request body for debugging
      // print('Request body: ${json.encode({
      //   "orderId": widget.orderID,
      //   "amount": 10,
      // })}');

      // Print the response status code for debugging
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          sessionId = responseData['sessionId']['id'];
          paymentUrl = responseData['sessionId']['url'];
          // print("session ID: $sessionId");
          // print("url: $paymentUrl");
          // print('Response Data:');
          // responseData.forEach((key, value) {
          //   print('$key: $value');
          // });
        });

        // Launch the payment URL directly
        // _launchUrl(paymentUrl);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Customer Payments'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: paymentUrl.isNotEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight(context) * 0.05, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: WebView(
                    initialUrl: paymentUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    navigationDelegate: (NavigationRequest request) {
                      print('Navigating to: ${request.url}');
                      if (request.url == 'https://www.google.com/') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerOrderConfirmationPage(
                                  token: widget.token,
                                  customerId: widget.customerId
                              )
                          ),
                        );
                        return NavigationDecision.prevent;
                      }
                      if (request.url == 'https://www.wikipedia.org/') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Order Cancelled'),
                              content: Text('The order has been cancelled.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Go Back to Home Page'),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => customerPage(
                                          token: widget.token,
                                          customerId: widget.customerId
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                ),
              ),
            )
                : const Center(
                  child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}