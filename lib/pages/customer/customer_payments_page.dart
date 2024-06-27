import 'dart:async';
import 'dart:convert';
import 'package:ap_landscaping/pages/customer/customer_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/pages/customer/create_order_success_page.dart';
import 'package:ap_landscaping/pages/customer/customer_home_page.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
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

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          sessionId = responseData['sessionId']['id'];
          paymentUrl = responseData['sessionId']['url'];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => CustomerOrderConfirmationPage(
                                  token: widget.token,
                                  customerId: widget.customerId)),
                              (Route<dynamic> route) => false,
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
                                        builder: (context) => CustomerMain(
                                            token: widget.token,
                                            customerId: widget.customerId),
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
