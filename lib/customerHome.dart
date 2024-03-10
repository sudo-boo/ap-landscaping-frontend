import 'dart:convert';
import 'package:ap_landscaping/main.dart';
import 'package:ap_landscaping/models/customerinfo.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class customerPage extends StatefulWidget {
  final token;
  final customerId;
  const customerPage({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<customerPage> createState() => _customerPageState();
}

class _customerPageState extends State<customerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person), // Profile Icon
          onPressed: () {
            // Handle profile icon action (e.g., navigate to profile page)
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Image(
              image: AssetImage('lib/assets/images/notificationsIcon.png'),
            ), // Notifications Bell Icon
            onPressed: () {
              // Handle notifications icon action (e.g., show notifications)
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -280,
              right: -280,
              top: -600,
              child: Container(
                width: 960,
                height: 960,
                decoration: const ShapeDecoration(
                  color: Color(0xFF73A580),
                  shape: OvalBorder(),
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Image(
                image: AssetImage('lib/assets/images/homeScreen.png'),
              ),
            ),
            const Positioned(
                left: 0,
                right: 0,
                top: 300,
                child: Text(
                  'Welcome Customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )),
            Positioned(
              top: 360,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 225),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => categoriesPage(
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: const Text(
                        'View All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3E363F),
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
            Positioned(
              top: 400,
              left: 0,
              right: 0,
              child: Container(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Lawn Treatment',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFE9E9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon1.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .cover, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFFBBC1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Lawn Treatment',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Leaf Removal',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFCEF29B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon2.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .contain, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF96C257),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Leaf Removal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Landscaping',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFDFABE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon3.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .contain, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFF4D376),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Landscaping',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Bush Trimming',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFEDCFD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon4.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .contain, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFFB0FE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Bush Trimming',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Mulching',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFDFCB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon5.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .cover, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFD9F67),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Mulching',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchedulingPage(
                                serviceName: 'Tree Care',
                                token: widget.token,
                                customerId: widget.customerId),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 75,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFB0E5FC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Padding inside the circle
                                child: Image.asset(
                                  'lib/assets/images/serviceIcon6.png', // Accessing the image from the assets
                                  fit: BoxFit
                                      .contain, // To ensure the image fits well within the circle
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 34,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF8DC3DA),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Tree Care',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none, // Allows the child to overflow the stack
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('lib/assets/images/homePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('lib/assets/images/communicationIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/images/moreIcon.png',
                      height: 45, width: 45),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(
                            token: widget.token, customerId: widget.customerId),
                      ),
                    );
                  },
                  // onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
            Positioned(
              top: -35, // Adjust this value to position the button as needed
              child: Container(
                height: 100, // Increase the height for a larger button
                width: 100, // Increase the width for a larger button
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  color: Color(0xFFBCDD8C), // Background color of the button
                ),
                child: IconButton(
                  icon: Image.asset(
                    'lib/assets/images/centerIcon.png',
                    height: 100, // Adjust the size of the inner image/icon
                    width: 100,
                  ),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class categoriesPage extends StatefulWidget {
  final token;
  final customerId;
  const categoriesPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<categoriesPage> createState() => _categoriesState();
}

class _categoriesState extends State<categoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: const Text(
          'Categories',
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
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 0,
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          // physics:
          //     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Lawn Treatment',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFE9E9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon1.png', // Accessing the image from the assets
                          fit: BoxFit
                              .cover, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFFBBC1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Lawn Treatment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Leaf Removal',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFCEF29B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon2.png', // Accessing the image from the assets
                          fit: BoxFit
                              .contain, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF96C257),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Leaf Removal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Landscaping',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFDFABE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon3.png', // Accessing the image from the assets
                          fit: BoxFit
                              .contain, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF4D376),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Landscaping',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Bush Trimming',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFEDCFD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon4.png', // Accessing the image from the assets
                          fit: BoxFit
                              .contain, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFFB0FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Bush Trimming',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Mulching',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFDFCB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon5.png', // Accessing the image from the assets
                          fit: BoxFit
                              .cover, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFFD9F67),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mulching',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Tree Care',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFB0E5FC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon6.png', // Accessing the image from the assets
                          fit: BoxFit
                              .contain, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF8DC3DA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tree Care',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingPage(
                        serviceName: 'Leaf Removal',
                        token: widget.token,
                        customerId: widget.customerId),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFCEF29B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding inside the circle
                        child: Image.asset(
                          'lib/assets/images/serviceIcon2.png', // Accessing the image from the assets
                          fit: BoxFit
                              .contain, // To ensure the image fits well within the circle
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF96C257),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Customize your service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none, // Allows the child to overflow the stack
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('lib/assets/images/homePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('lib/assets/images/communicationIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/images/moreIcon.png',
                      height: 45, width: 45),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(
                            token: widget.token, customerId: widget.customerId),
                      ),
                    );
                  },
                  // onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
            Positioned(
              top: -35, // Adjust this value to position the button as needed
              child: Container(
                height: 100, // Increase the height for a larger button
                width: 100, // Increase the width for a larger button
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  color: Color(0xFFBCDD8C), // Background color of the button
                ),
                child: IconButton(
                  icon: Image.asset(
                    'lib/assets/images/centerIcon.png',
                    height: 100, // Adjust the size of the inner image/icon
                    width: 100,
                  ),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class myServicesPage extends StatefulWidget {
  final token;
  final customerId;
  const myServicesPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);
  @override
  State<myServicesPage> createState() => _myServicesPageState();
}

class _myServicesPageState extends State<myServicesPage> {
  // Future<List<orderInfo>> customerOrdersList() async {
  //   final response = await http.get(
  //     Uri.parse('$customerOrders${widget.customerId}'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': '${widget.token}',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> ordersJson = json.decode(response.body)['orders'];
  //     final List<orderInfo> orders = ordersJson.map((order) {
  //       return orderInfo(
  //           serviceType: order['serviceType'],
  //           address: order['address'],
  //           date: order['date'],
  //           time: order['time'],
  //           expectationNote: order['expectationNote'].toString(),
  //           customerId: order['customerId'],
  //           providerId: order['providerId'],
  //           isFinished: order['isFinished'],
  //           isCancelled: order['isCancelled'],
  //           id: order['id']);
  //     }).toList();
  //     // print();
  //     return orders;
  //   } else {
  //     throw Exception('Failed to load customer orders');
  //   }
  // }

  late Future<List<orderInfo>> pastorders;
  late Future<List<orderInfo>> futureorders;

  @override
  void initState() {
    super.initState();
    // Initial call to providerPreviousOrdersList
    pastorders = customerPreviousOrdersList();
    futureorders = customerUpcomingOrdersList();
  }

  Future<List<orderInfo>> customerPreviousOrdersList() async {
    final response = await http.get(
      Uri.parse(customerPastOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson = json.decode(response.body)['pastOrders'];
      final List<orderInfo> orders = [];
      for (var order in ordersJson) {
        final providerDetails =
            await getProviderDetailsById(order['providerId']);
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'],
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'],
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          providerName: providerDetails.username,
          // Add other customer details as needed
        ));
      }
      // print();
      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  Future<List<orderInfo>> customerUpcomingOrdersList() async {
    final response = await http.get(
      Uri.parse(customerUpcomingOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson =
          json.decode(response.body)['upcomingOrders'];
      final List<orderInfo> orders = [];
      for (var order in ordersJson) {
        final providerDetails =
            await getProviderDetailsById(order['providerId']);
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'],
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'],
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          providerName: providerDetails.username,
          // Add other customer details as needed
        ));
      }
      // print();
      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  Future<providerInfo> getProviderDetailsById(String provider_id) async {
    try {
      final response = await http.get(
        Uri.parse('$providerDetailsbyId${provider_id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return providerInfo(
          username: data['provider']['username'] ?? '',
          email: data['provider']['email'] ?? '',
          mobile_number: data['provider']['mobilenumber'] ?? '',
          address: data['provider']['address'] ?? '',
        );
      } else if (response.statusCode == 404) {
        // return {'error': 'Order not found'};
        return providerInfo();
      } else {
        // return {'error': 'Failed to fetch order'};
        return providerInfo();
      }
    } catch (e) {
      print('Error getting order: $e');
      return providerInfo();
      // return {'error': 'Failed to fetch order'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // title: Text(widget.serviceName),
          title: const Text(
            'My Services',
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
          actions: <Widget>[
            IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/notificationsIcon.png'),
              ), // Notifications Bell Icon
              onPressed: () {
                // Handle notifications icon action (e.g., show notifications)
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                // text: 'Upcoming',
              ),
              Tab(
                child: Text(
                  'Past',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                // text: 'Past',
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(
                  // color: Colors.green[100],
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          futureorders = customerUpcomingOrdersList();
                        });
                        // Refresh the UI
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FutureBuilder<List<orderInfo>>(
                          future: futureorders,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No orders found.');
                            } else {
                              final orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders?.length,
                                itemBuilder: (context, index) {
                                  final order = orders?[index];
                                  String statusText;
                                  Color statusColor;
                                  if (order!.isCancelled) {
                                    statusText = 'Cancelled';
                                    statusColor = const Color(0xFFEA2F2F);
                                  } else if (order.isFinished) {
                                    statusText = 'Finished';
                                    statusColor = const Color(0xFF3BAE5B);
                                  } else {
                                    statusText = 'Pending';
                                    statusColor = Colors.orange;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(children: [
                                      Card(
                                        color: const Color(0xFFCEF29B),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  order.serviceType,
                                                  // textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Color(0xFF1C1F34),
                                                    fontSize: 24,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    24.0, 40.0, 24.0, 24.0),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Date',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order!.date,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Time',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.time,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Provider',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerName,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Payment mode',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerId,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    // ListTile(
                                                    //   title: Text(
                                                    //     order.serviceType,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    //   subtitle: Text(
                                                    //     order.date,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OrderDetailsPage(
                                                                  token:
                                                                      widget.token,
                                                                  customerId: widget
                                                                      .customerId,
                                                                  orderId: order.id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green[900],
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
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
                                      ),
                                      Positioned(
                                        top: 69,
                                        left: 30,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          pastorders = customerPreviousOrdersList();
                        });
                        // Refresh the UI
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FutureBuilder<List<orderInfo>>(
                          future: pastorders,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No orders found.');
                            } else {
                              final orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders?.length,
                                itemBuilder: (context, index) {
                                  final order = orders?[index];
                                  String statusText;
                                  Color statusColor;
                                  if (order!.isCancelled) {
                                    statusText = 'Cancelled';
                                    statusColor = const Color(0xFFEA2F2F);
                                  } else if (order.isFinished) {
                                    statusText = 'Finished';
                                    statusColor = const Color(0xFF3BAE5B);
                                  } else {
                                    statusText = 'Pending';
                                    statusColor = Colors.orange;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(children: [
                                      Card(
                                        color: const Color(0xFFCEF29B),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  order.serviceType,
                                                  // textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Color(0xFF1C1F34),
                                                    fontSize: 24,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    24.0, 40.0, 24.0, 24.0),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Date',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order!.date,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Time',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.time,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Provider',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerName,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                            const Color(0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Payment mode',
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerId,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    // ListTile(
                                                    //   title: Text(
                                                    //     order.serviceType,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    //   subtitle: Text(
                                                    //     order.date,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OrderDetailsPage(
                                                                  token:
                                                                      widget.token,
                                                                  customerId: widget
                                                                      .customerId,
                                                                  orderId: order.id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green[900],
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
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
                                      ),
                                      Positioned(
                                        top: 69,
                                        left: 30,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none, // Allows the child to overflow the stack
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('lib/assets/images/homeIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => customerPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    },
                    // onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                      icon: Image.asset(
                          'lib/assets/images/myServicesPressedIcon.png',
                          height: 45,
                          width: 45),
                      onPressed: () {
                        // _onItemTapped(1);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => myServicesPage(
                        //             token: widget.token,
                        //             customerId: widget.customerId)));
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('lib/assets/images/communicationIcon.png',
                        height: 45, width: 45),
                    onPressed: () {},
                    // onPressed: () => _onItemTapped(3),
                  ),
                  IconButton(
                    icon: Image.asset('lib/assets/images/moreIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => profilePage(
                              token: widget.token,
                              customerId: widget.customerId),
                        ),
                      );
                    },
                    // onPressed: () => _onItemTapped(4),
                  ),
                ],
              ),
              Positioned(
                top: -35, // Adjust this value to position the button as needed
                child: Container(
                  height: 100, // Increase the height for a larger button
                  width: 100, // Increase the width for a larger button
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // Ensures the container is circular
                    color: Color(0xFFBCDD8C), // Background color of the button
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'lib/assets/images/centerIcon.png',
                      height: 100, // Adjust the size of the inner image/icon
                      width: 100,
                    ),
                    onPressed: () {},
                    // onPressed: () => _onItemTapped(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderDetailsPage extends StatefulWidget {
  final token;
  final customerId;
  final orderId;
  const OrderDetailsPage({Key? key, this.token, this.customerId, this.orderId})
      : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isLoading = true;
  orderInfo order_info = orderInfo();
  providerInfo provider_info = providerInfo();
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await getOrderById();
    getProviderDetailsById();
  }

  Future<void> getOrderById() async {
    try {
      final response = await http.get(
        Uri.parse('$getOrder${widget.orderId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          order_info.serviceType = data['order']['serviceType'] ?? '';
          order_info.address = data['order']['address'] ?? '';
          order_info.date = data['order']['date'] ?? '';
          order_info.time = data['order']['time'] ?? '';
          order_info.expectationNote = data['order']['expectationNote'] ?? '';
          order_info.customerId = data['order']['customerId'] ?? '';
          order_info.providerId = data['order']['providerId'] ?? '';
          order_info.isFinished = data['order']['isFinished'] ?? '';
          order_info.isCancelled = data['order']['isCancelled'] ?? '';
          order_info.id = data['order']['id'] ?? '';
          // isLoading = false;
        });
      } else if (response.statusCode == 404) {
        // return {'error': 'Order not found'};
      } else {
        // return {'error': 'Failed to fetch order'};
      }
    } catch (e) {
      print('Error getting order: $e');
      // return {'error': 'Failed to fetch order'};
    }
  }

  Future<void> getProviderDetailsById() async {
    try {
      final response = await http.get(
        Uri.parse('$providerDetailsbyId${order_info.providerId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          provider_info.username = data['provider']['username'] ?? '';
          provider_info.email = data['provider']['email'] ?? '';
          provider_info.mobile_number = data['provider']['mobilenumber'] ?? '';
          // provider_info.password = data['provider']['username'] ?? '';
          provider_info.address = data['provider']['address'] ?? '';
          // provider_info.card_details = data['provider']['username'] ?? '';
          // provider_info.cvv = data['provider']['username'] ?? '';
          // provider_info.paypal_id = data['provider']['username'] ?? '';
          // provider_info.aec_transfer = data['provider']['username'] ?? '';
          // provider_info.card_type = data['provider']['username'] ?? '';
          // provider_info.card_holders_name = data['provider']['username'] ?? '';
          // provider_info.card_number = data['provider']['username'] ?? '';
          provider_info.qualifications = data['provider']['username'] ?? '';
          provider_info.years_of_experience =
              data['provider']['yearsofexperience'] ?? 0;
          provider_info.bio = data['provider']['bio'] ?? '';
          // provider_info.bank_name = data['provider']['username'] ?? '';
          // provider_info.account_nummber = data['provider']['username'] ?? '';
          // provider_info.services = data['provider']['services'] ?? '';
          provider_info.google_id = data['provider']['googleId'] ?? '';
          isLoading = false;
        });
      } else if (response.statusCode == 404) {
        // return {'error': 'Order not found'};
      } else {
        // return {'error': 'Failed to fetch order'};
      }
    } catch (e) {
      print('Error getting order: $e');
      // return {'error': 'Failed to fetch order'};
    }
  }

  Future<void> cancelOrderFunc() async {
    try {
      // var cBody = {
      //   'reason': reasonController.text,
      //   'additionalInfo': additionalInfo.text
      // };
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

  void showCustomCancellationBottomSheet(BuildContext context) {
    TextEditingController _reasonController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6),
                child: Container(
                  width: double.maxFinite,
                  height: 22,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFA686FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(
                        width: 279,
                        child: Text(
                          'Cancel Booking ',
                          style: TextStyle(
                            color: Color(0xFF3E363F),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Warning !',
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                child: SizedBox(
                  // width: 335,
                  child: Text(
                    "Are you sure you want to cancel your requested service? This action cannot be undone. Please confirm to proceed with the cancellation.",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromRGBO(187, 225, 197, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'lib/assets/images/reasonIcon.png',
                            // height: 45, width: 45
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _reasonController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Reason',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              // labelStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Removes the underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    cancelOrderFunc();
                  },
                  child: Container(
                    width: 327,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA686FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel  Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showCustomReschedulingBottomSheet(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    TextEditingController _reasonController = TextEditingController();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    }

    // Function to handle time selection
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }

    Future<void> rescheduleOrderFunc() async {
      try {
        var cBody = {
          'reason': _reasonController.text,
        };
        final response = await http.put(
          Uri.parse(
              '$rescheduleByCustomer${widget.orderId}'), // Replace with your API endpoint
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode(order_info),
        );

        if (response.statusCode == 200) {
          print('Order Rescheduled successfully');
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

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6),
                  child: Container(
                    width: double.maxFinite,
                    height: 22,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFA686FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(
                          width: 279,
                          child: Text(
                            'Select your Date & Time?',
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color(0xFFFFE9E9),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            "Select Date of Service: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                        leading: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                      ),
                      ListTile(
                        title: Text(
                            "Select Time of Service: ${selectedTime.format(context)}"),
                        leading: const Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color(0xFFFDFABE),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'lib/assets/images/reasonIcon.png',
                            // height: 45, width: 45
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _reasonController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Reason',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              // labelStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Removes the underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    order_info.date =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    order_info.time =
                        "${selectedTime.hour}:${selectedTime.minute}";
                    rescheduleOrderFunc();
                  },
                  child: Container(
                    width: 327,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA686FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reschedule  Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!isLoading &&
        !order_info.isCancelled &&
        !order_info.isFinished) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // backgroundColor: Colors.green[900],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      // ListTile(
                      //   title: Text('Booking ID'),
                      //   subtitle: Text('#123'),
                      //   trailing: Text('9:41'),
                      // ),
                      ListTile(
                        // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
                        title: Text(order_info.serviceType),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date:   ${order_info.date}'),
                            Text('Time:   ${order_info.time}'),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   title: const Text('Status'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Duration'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // const ListTile(
                      //   title: Text('Price Detail'),
                      //   subtitle: Text('Price: ₹120'),
                      // ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Provider',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Card(
                      color: const Color(0xFFFFE9E9),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              provider_info.username,
                              style: const TextStyle(
                                color: Color(0xFF3E363F),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded,
                                        color: Color(0xFF3E363F)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showCustomReschedulingBottomSheet(context);
                },
                child: Container(
                  width: 334,
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFA686FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reschedule Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showCustomCancellationBottomSheet(context);
                },
                child: Container(
                  width: 336,
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFA686FF)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel Booking',
                              style: TextStyle(
                                color: Color(0xFFA686FF),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // backgroundColor: Colors.green[900],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      // ListTile(
                      //   title: Text('Booking ID'),
                      //   subtitle: Text('#123'),
                      //   trailing: Text('9:41'),
                      // ),
                      ListTile(
                        // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
                        title: Text(order_info.serviceType),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date:   ${order_info.date}'),
                            Text('Time:   ${order_info.time}'),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   title: const Text('Status'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Duration'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // const ListTile(
                      //   title: Text('Price Detail'),
                      //   subtitle: Text('Price: ₹120'),
                      // ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Provider',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Card(
                      color: const Color(0xFFFFE9E9),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              provider_info.username,
                              style: const TextStyle(
                                color: Color(0xFF3E363F),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded,
                                        color: Color(0xFF3E363F)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      provider_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

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

class SchedulingPage extends StatefulWidget {
  final token;
  final customerId;
  final String serviceName;

  const SchedulingPage(
      {Key? key, required this.serviceName, this.token, this.customerId})
      : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  orderInfo order_info = orderInfo();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController expectationsController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: 'Default Address of the user');

  // Function to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Function to handle time selection
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                          color: Color(0xFFA686FF),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 11,
                                      top: 11,
                                      child: Text(
                                        '01',
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
                            Positioned(
                              left: 55,
                              top: 18.50,
                              child: Container(
                                width: 100,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.50,
                                      strokeAlign: BorderSide.strokeAlignCenter,
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
                                          color: Colors.white,
                                          shape: OvalBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Color(0xFF3E363F)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Text(
                                        '02',
                                        style: TextStyle(
                                          color: Color(0xFF3E363F),
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
            const SizedBox(height: 15),
            Card(
              color: const Color(0xFFCEF29B),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                      child: ListTile(
                        // tileColor: Colors.white,
                        title: Text(
                            "Select Date of Service: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                        leading: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                      child: ListTile(
                        title: Text(
                            "Select Time of Service: ${selectedTime.format(context)}"),
                        leading: const Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                      child: TextField(
                        controller: addressController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Edit Address',
                          hintText: 'Enter your address',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          // border: OutlineInputBorder(),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the border radius as needed
                ),
                child: TextField(
                  controller: expectationsController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: "Expectation Note",
                    hintText: "Describe your expectations",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // const Spacer(),
            InkWell(
              onTap: () {
                order_info.serviceType = widget.serviceName;
                order_info.date = DateFormat('yyyy-MM-dd').format(selectedDate);
                order_info.time = "${selectedTime.hour}:${selectedTime.minute}";
                order_info.address = addressController.text;
                order_info.expectationNote = expectationsController.text;
                order_info.customerId = widget.customerId;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BillingPage(
                              token: widget.token,
                              customerId: widget.customerId,
                              order_info: order_info,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFA686FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              // height: 0,
                              letterSpacing: -0.07,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    expectationsController.dispose();
    addressController.dispose();
    super.dispose();
  }
}

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
      Navigator.push(
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
                        builder: (context) => myServicesPage(
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

class profilePage extends StatefulWidget {
  final token;
  final customerId;
  const profilePage({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  void showCustomSignOutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: Text(
                  "Are you sure you want to sign out?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign out logic
                    logoutCustomer();
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFA686FF), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Sign out",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFA686FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> logoutCustomer() async {
    var url = Uri.parse(customerLogout); // Replace with your actual endpoint
    try {
      print(widget.token);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}', // Include the token in the header
        },
      );

      if (response.statusCode == 200) {
        print('Logout successful');
        await SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
          prefs.remove('userOrProvider');
          prefs.remove('id');
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'AP Landscaping',
                  )),
          (Route<dynamic> route) => false,
        );
        // Handle successful logout
      } else {
        print(response.statusCode);
        // print(response['error']);
        print(json.decode(response.body)['error']);
        print('Failed to logout');
        // Handle error response
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle any exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: const Text(
          'More',
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
      body: Container(
        color: const Color(0xFFBBE1C5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF3E363F),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/userIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'My Account',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => updateprofileInfoPage(
                                      token: widget.token,
                                      customerId: widget.customerId)));
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF96C257),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/settingsIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFC8B88A),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/logoutIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'Sign out',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showCustomSignOutBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none, // Allows the child to overflow the stack
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('lib/assets/images/homeIcon.png',
                      height: 45, width: 45),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => customerPage(
                                token: widget.token,
                                customerId: widget.customerId)));
                  },
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('lib/assets/images/communicationIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/images/morePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
            Positioned(
              top: -35, // Adjust this value to position the button as needed
              child: Container(
                height: 100, // Increase the height for a larger button
                width: 100, // Increase the width for a larger button
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  color: Color(0xFFBCDD8C), // Background color of the button
                ),
                child: IconButton(
                  icon: Image.asset(
                    'lib/assets/images/centerIcon.png',
                    height: 100, // Adjust the size of the inner image/icon
                    width: 100,
                  ),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class updateprofileInfoPage extends StatefulWidget {
  final token;
  final customerId;
  const updateprofileInfoPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<updateprofileInfoPage> createState() => _updateprofileInfoPageState();
}

class _updateprofileInfoPageState extends State<updateprofileInfoPage> {
  customerInfo customer_info = customerInfo();
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileNumberController = TextEditingController(text: '');
    fetchCustomerInfo().then((fetchedCustomerInfo) {
      _usernameController.text = fetchedCustomerInfo.username ?? '';
      _emailController.text = fetchedCustomerInfo.email ?? '';
      _addressController.text = fetchedCustomerInfo.address ?? '';
      _mobileNumberController.text = fetchedCustomerInfo.mobile_number ?? '';
      setState(() {
        customer_info = fetchedCustomerInfo;
        isLoading = false;
      });
    });
  }

  Future<customerInfo> fetchCustomerInfo() async {
    customerInfo customer_info1 = customerInfo();
    final url = Uri.parse(customerProfileInfo); // Replace with your API URL
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          customer_info1.username = data['customer']['username'] ?? '';
          customer_info1.email = data['customer']['email'] ?? '';
          customer_info1.mobile_number = data['customer']['mobilenumber'] ?? '';
          customer_info1.password = data['customer']['password'] ?? '';
          customer_info1.address = data['customer']['address'] ?? '';
          customer_info1.card_details = data['customer']['carddetails'] ?? '';
          customer_info1.cvv = data['customer']['cvv'] ?? '';
          customer_info1.paypal_id = data['customer']['paypalid'] ?? '';
          customer_info1.aec_transfer = data['customer']['aectransfer'] ?? '';
          customer_info1.card_type = data['customer']['cardtype'] ?? '';
          customer_info1.card_holders_name =
              data['customer']['cardholdersname'] ?? '';
          customer_info1.card_number = data['customer']['cardnumber'] ?? '';
          isLoading = false;
        });
        return customer_info1;
      } else {
        // Handle error or non-200 responses
        print('Failed to fetch customer info');
        return customer_info1;
      }
    } catch (e) {
      print('Error: $e');
      return customer_info1;
    }
  }

  Future<void> updateCustomerInfo() async {
    final url = Uri.parse(customerProfileInfo);
    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode({
            'username': customer_info.username,
            'email': customer_info.email,
            'mobilenumber': customer_info.mobile_number,
            'address': customer_info.address,
            'carddetails': customer_info.card_details,
            'cvv': customer_info.cvv,
            'paypalid': customer_info.paypal_id,
            'aectransfer': customer_info.aec_transfer,
            'cardtype': customer_info.card_type,
            'cardholdersname': customer_info.card_holders_name,
            'cardnumber': customer_info.card_number,
          }));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          customer_info.username = data['updatedCustomer']['username'] ?? '';
          customer_info.email = data['updatedCustomer']['email'] ?? '';
          customer_info.mobile_number =
              data['updatedCustomer']['mobilenumber'] ?? '';
          customer_info.address = data['updatedCustomer']['address'] ?? '';
          customer_info.card_details =
              data['updatedCustomer']['carddetails'] ?? '';
          customer_info.cvv = data['updatedCustomer']['cvv'] ?? '';
          customer_info.paypal_id = data['updatedCustomer']['paypalid'] ?? '';
          customer_info.aec_transfer =
              data['updatedCustomer']['aectransfer'] ?? '';
          customer_info.card_type = data['updatedCustomer']['cardtype'] ?? '';
          customer_info.card_number =
              data['updatedCustomer']['cardnumber'] ?? '';
        });
        print('Customer profile updated successfully');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Profile Successfully Updated"),
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
        print('Failed to update customer profile');
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
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'My Account',
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
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                      // onSaved: (value) =>
                      //     widget.customer_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      // onSaved: (value) =>
                      //     widget.customer_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      // onSaved: (value) =>
                      //     widget.customer_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                    child: TextFormField(
                      controller: _mobileNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                      // onSaved: (value) =>
                      //     widget.customer_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          customer_info.username = _usernameController.text;
                          customer_info.email = _emailController.text;
                          customer_info.address = _addressController.text;
                          customer_info.mobile_number =
                              _mobileNumberController.text;
                        });
                        updateCustomerInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        // backgroundColor: Colors.blue,
                        backgroundColor: const Color(0xFFA686FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ), // Calling the update function
                      child: const Text('Update Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
