import 'dart:math';

import 'package:ap_landscaping/pages/customer/customer_home.dart';
import 'package:ap_landscaping/pages/customer/customer_my_services_page.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CustomerOrderConfirmationPage extends StatefulWidget {
  final token;
  final customerId;
  const CustomerOrderConfirmationPage({
    Key? key,
    required this.token,
    required this.customerId
  }) : super(key: key);

  @override
  _CustomerOrderConfirmationPageState createState() => _CustomerOrderConfirmationPageState();
}

class _CustomerOrderConfirmationPageState extends State<CustomerOrderConfirmationPage> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));

    _controllerTopCenter.play();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[

          Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 250),
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
                      fontFamily: 'Inter',
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerServicesPage(
                            token: widget.token,
                            customerId: widget.customerId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                      textStyle: const TextStyle(fontSize: 16), // Text style
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'View my Services',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: fontHelper(context) * 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => customerPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                      textStyle: const TextStyle(fontSize: 16), // Text style
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Book another Service',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: fontHelper(context) * 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2,
              maxBlastForce: 3,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 30, // a lot of particles at once
              gravity: 0.07,
              colors: const [
                Colors.greenAccent, Colors.yellowAccent, Colors.black
              ],
            ),
          ),
        ]
      )
    );
  }
}
