import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FirstScrollPage extends StatefulWidget {
  const FirstScrollPage({super.key});

  @override
  State<FirstScrollPage> createState() => _FirstScrollPageState();
}

class _FirstScrollPageState extends State<FirstScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green.shade100,
      child: Stack(
        children: [
          const Positioned(
            right: 0,
            top: 70,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud1.png'),
            ),
          ),
          const Positioned(
            left: 0,
            top: 60,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud2.png'),
            ),
          ),
          const Positioned(
            left: 0,
            top: 300,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud3.png'),
            ),
          ),
          const Positioned(
            right: 0,
            top: 200,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud4.png'),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight(context) * 0.23,
            child: Padding(
              padding: EdgeInsets.all(screenWidth(context) * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenHeight(context) * 0.45,
                    height: screenHeight(context) * 0.45,
                    child: Image.asset("assets/images/ScrollPage1.png"),
                  ),
                  SizedBox(height: 20), // Add spacing between the image and the text
                  Text(
                    "All Lawn Care Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing between the texts
                  Text(
                    "Transforming Your Lawn into a Lush Paradise",
                    style: TextStyle(
                      color: Color(0xFF960505),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScrollPage extends StatefulWidget {
  const SecondScrollPage({super.key});

  @override
  State<SecondScrollPage> createState() => _SecondScrollPageState();
}

class _SecondScrollPageState extends State<SecondScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC8B88A),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            top: 50,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage2vector1.png'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight(context) * 0.35,
            child: Padding(
              padding: EdgeInsets.all(screenWidth(context) * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // width: screenHeight(context) * 0.45,
                    // height: screenHeight(context) * 0.45,
                    child: Image.asset("assets/images/ScrollPage2.png"),
                  ),
                  SizedBox(height: 20), // Add spacing between the image and the text
                  Text(
                    "Donation Pick-Up Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing between the texts
                  Text(
                    "Simplifying Donations, One Pick-Up at a Time",
                    style: TextStyle(
                      color: Color(0xFF960505),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThirdScrollPage extends StatefulWidget {
  const ThirdScrollPage({super.key});

  @override
  State<ThirdScrollPage> createState() => _ThirdScrollPageState();
}

class _ThirdScrollPageState extends State<ThirdScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF8CF3F3),
      child: Stack(
        children: [
          const Positioned(
            right: 0,
            top: 60,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud1.png'),
            ),
          ),
          const Positioned(
            left: 0,
            top: 100,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud2.png'),
            ),
          ),
          const Positioned(
            left: 0,
            top: 350,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud3.png'),
            ),
          ),
          const Positioned(
            right: 0,
            top: 200,
            child: Image(
              image: AssetImage(
                  'assets/images/welcomePage1cloud4.png'),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight(context) * 0.3,
            child: Padding(
              padding: EdgeInsets.all(screenWidth(context) * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // width: screenHeight(context) * 0.45,
                    // height: screenHeight(context) * 0.45,
                    child: Image.asset("assets/images/ScrollPage3.png"),
                  ),
                  SizedBox(height: 20), // Add spacing between the image and the text
                  Text(
                    "Traditional Moving Services ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing between the texts
                  Text(
                    "Trusted Partner for Hassle-Free Relocations",
                    style: TextStyle(
                      color: Color(0xFF960505),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FourthScrollPage extends StatefulWidget {
  const FourthScrollPage({super.key});

  @override
  State<FourthScrollPage> createState() => _FourthScrollPageState();
}

class _FourthScrollPageState extends State<FourthScrollPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC7ECD1),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Image(
              image: AssetImage('assets/images/ScrollPage4.png'),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            top: screenHeight(context) * 0.65,
            child: SizedBox(
              child: Column(
                children: [
                  Text(
                    "Would you like to register as a customer seeking landscaping services, or as a service provider offering your landscaping expertise?",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: fontHelper(context) * 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      // height: 0.08,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                          const Color(0xFF3E363F), // Text color
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/customersignin');
                        },
                        child: Text('Customer',
                            style: TextStyle(
                              fontSize: fontHelper(context) * 16,
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.30,
                            )),
                      ),
                      // const SizedBox(width: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                          const Color(0xFF3E363F), // Text color
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/providersignin');
                        },
                        child: Text('Provider',
                            style: TextStyle(
                              fontSize: fontHelper(context) * 16,
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.30,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 50,
              right: 50,
              top: screenHeight(context) * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Superuser? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/superusersignin');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove padding
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Minimize the tap target size
                    ),
                    child: const Text(
                      'Click here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
