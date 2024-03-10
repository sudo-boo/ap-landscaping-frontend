import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';

class CancellationPage extends StatefulWidget {
  final token;
  final customerId;
  final orderId;
  const CancellationPage({Key? key, this.token, this.customerId, this.orderId})
      : super(key: key);

  @override
  _CancellationPageState createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  Future<void> cancelOrderFunc() async {
    try {
      var cBody = {
        'reason': reasonController.text,
        'additionalInfo': additionalInfo.text
      };
      final response = await http.put(
        Uri.parse(
            '$cancelOrderByCustomer${widget.orderId}'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: json.encode({'isCancelled': true}),
      );

      if (response.statusCode == 200) {
        print('Order cancelled successfully');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Order cancelled successfully"),
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
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (error) {
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
      print('Error cancelling order: $error');
      // throw Exception('Internal Server Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Cancellation Form'),
          backgroundColor: Colors.green[900],
        ),
        body: Container(
            width: double.infinity,
            color: Colors.green[100],
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Cancallation may cost you.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 100),
                          // Service information
                          const SizedBox(height: 100),
                          Card(
                            child: TextField(
                              controller: reasonController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                labelText: "Reason for cancellation",
                                // hintText: "Describe your expectations",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Card(
                            child: TextField(
                              controller: additionalInfo,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "additional information",
                                // hintText: "Describe your expectations",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[900]),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cancelOrderFunc();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[900]),
                                child: const Text(
                                  'Confirm Cancellation',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ])))));
  }

  @override
  void dispose() {
    reasonController.dispose();
    additionalInfo.dispose();
    super.dispose();
  }
}
