import 'package:ap_landscaping/pages/customer/my_services_page.dart';
import 'package:ap_landscaping/pages/customer/profile_page.dart';
import 'package:ap_landscaping/pages/customer/scheduling_page.dart';
import 'package:flutter/material.dart';


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

