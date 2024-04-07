import 'dart:convert';
import 'package:ap_landscaping/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CustomerPaymentsPage extends StatefulWidget {
  final String token;
  final String customerId;
  final String orderID;

  const CustomerPaymentsPage(
      {required this.token,
        required this.customerId,
        required this.orderID,
        Key? key})
      : super(key: key);

  @override
  State<CustomerPaymentsPage> createState() => _CustomerPaymentsPageState();
}

class _CustomerPaymentsPageState extends State<CustomerPaymentsPage> {
  String sessionId = '';
  String paymentUrl = '';

  @override
  void initState() {
    super.initState();
    createPayment();
  }

  Future<void> _launchUrl(String paymenturl) async {
    print('Launching payment URL...');
    try {
      await launch(paymenturl, forceWebView: true, enableJavaScript: true);
      print('Payment URL launched successfully.');
    } catch (e) {
      print('Could not launch payment URL: $e');
      // Handle the error gracefully
    }
  }

  void createPayment() async {
    try {
      final response = await http.post(
        Uri.parse(paymentEngage),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: json.encode({
          "orderId": widget.orderID,
          "amount": 10
        }),
      );

      // Print the request body for debugging
      print('Request body: ${json.encode({
        "orderId": widget.orderID,
        "amount": 10,
      })}');

      // Print the response status code for debugging
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          sessionId = responseData['sessionId']['id'];
          paymentUrl = responseData['sessionId']['url'];
          print("session ID: $sessionId");
          print("url: $paymentUrl");
          print('Response Data:');
          responseData.forEach((key, value) {
            print('$key: $value');
          });

          // Launch the payment URL directly
          _launchUrl(paymentUrl);
        });
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
      appBar: AppBar(
        title: Text('Customer Payments'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
