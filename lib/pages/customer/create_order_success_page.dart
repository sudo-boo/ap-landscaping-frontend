import 'dart:math';

import 'package:ap_landscaping/pages/customer/customer_home_page.dart';
import 'package:ap_landscaping/pages/customer/customer_main.dart';
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
        ConfettiController(duration: const Duration(seconds: 3));

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
                const SizedBox(height: 80),
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
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'You\'ll soon receive a call about your services!\n\nThank You!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerMain(
                          token: widget.token,
                          customerId: widget.customerId
                        )
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      height: 50,
                      width: screenWidth(context) * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50), // Changed color to a more appropriate green
                          borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child:
                      const Text(
                        'Go to Home Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          letterSpacing: -0.07,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => CustomerHomePage(
                //                 token: widget.token,
                //                 customerId: widget.customerId
                //             )
                //         )
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                //     child: Container(
                //       height: 50,
                //       width: screenWidth(context) * 0.6,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         border: Border.all(
                //           color: const Color(0xFFB895FC)
                //         )
                //       ),
                //       alignment: Alignment.center,
                //       child: const Text(
                //         'Go to Home Page',
                //         style: TextStyle(
                //           color: const Color(0xFFB895FC),
                //           fontSize: 16,
                //           fontFamily: 'Inter',
                //           fontWeight: FontWeight.w600,
                //           letterSpacing: -0.07,
                //         ),
                //       ),),
                //   ),
                // ),
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
            numberOfParticles: 40, // a lot of particles at once
            gravity: 0.05,
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
