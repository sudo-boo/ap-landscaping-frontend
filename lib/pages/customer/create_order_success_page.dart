import 'package:ap_landscaping/pages/customer/customer_home.dart';
import 'package:ap_landscaping/pages/customer/my_services_page.dart';
import 'package:flutter/material.dart';

class CongratsPage extends StatefulWidget {
  final token;
  final customerId;
  const CongratsPage({Key? key, this.token, this.customerId}) : super(key: key);

  @override
  _CongratsPageState createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 100),
          const Icon(
            Icons.check_circle_outline,
            size: 100,
            color: Colors.green,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Congratulations, your order has been placed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerServicesPage(
                            token: widget.token,
                            customerId: widget.customerId)));
              },
              child: const Text('View my Services'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => customerPage(
                            token: widget.token,
                            customerId: widget.customerId)));
              },
              child: const Text('Order another Service'),
            ),
          ),
        ],
      ),
    );
  }
}
