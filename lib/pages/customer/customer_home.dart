import 'dart:convert';
import 'package:ap_landscaping/utilities/customer_home_category_card.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/categories_page.dart';
import 'package:ap_landscaping/pages/customer/customer_my_services_page.dart';
import 'package:ap_landscaping/pages/customer/customer_profile_page.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../models/customerinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customerPage extends StatefulWidget {
  final token;
  final customerId;
  const customerPage({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<customerPage> createState() => _customerPageState();
}

class _customerPageState extends State<customerPage> {
  // Define customerInfo1 at the class level
  customerInfo customerInfo1 = customerInfo();

  Future<void> fetchAndSaveCustomerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the name is null in SharedPreferences
    String? savedName = prefs.getString('name');
    if (savedName == null) {
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
            // Update customerInfo1 with fetched data
            customerInfo1.username = data['customer']['username'] ?? '';
            // Other assignments...
          });

          await prefs.setString('name', customerInfo1.username);
          // Print confirmation message
          print('Username set in SharedPreferences: ${customerInfo1.username}');
        } else {
          // Handle error or non-200 responses
          print('Failed to fetch customer info');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      // Name already exists in SharedPreferences, no need to fetch
      print('Name already exists in SharedPreferences: $savedName');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndSaveCustomerInfo();
  }

  Widget build(BuildContext context) {
    Dimensions getDims = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person,
            size: 35,
          ), // Profile Icon
          onPressed: () {
            // Handle profile icon action (e.g., navigate to profile page)
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              size: 35,
            ),
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
              top: -screenHeight(context) * 0.82,
              child: Container(
                height: screenHeight(context) * 1.3,
                decoration: const ShapeDecoration(
                  color: Color(0xFF73A580),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Image(
                image: AssetImage('assets/images/homeScreen.png',),
                height: screenHeight(context) * 0.4,
              ),
            ),
            Positioned(
                top: screenHeight(context) * 0.4,
                left: 0,
                right: 0,
                child: Text(
                  'Welcome Customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: fontHelper(context) * 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )),
            Positioned(
              top: screenHeight(context) * 0.47,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: fontHelper(context) * 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(width: getDims.fractionWidth(0.55)),
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
                      child: Text(
                        'View All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3E363F),
                          fontSize: fontHelper(context) * 14,
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
              top: screenHeight(context) * 0.52,
              left: 0,
              right: 0,
              child: Container(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    HomePageCategoryCard(
                        serviceName: 'Lawn Treatment',
                        token: widget.token,
                        customerId: widget.customerId,
                        imageLink: 'assets/images/serviceIcon1.png',
                        containerColorTop: const Color(0xFFFFE9E9),
                        containerColorBottom: const Color(0xFFFFBBC1),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Leaf Removal',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/serviceIcon2.png',
                      containerColorTop: const Color(0xFF96C257),
                      containerColorBottom: const Color(0xFF96C257),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Landscaping',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/serviceIcon3.png',
                      containerColorTop: const Color(0xFFFDFABE),
                      containerColorBottom: const Color(0xFFF4D376),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Bush Trimming',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/serviceIcon4.png',
                      containerColorTop: const Color(0xFFFEDCFD),
                      containerColorBottom: const Color(0xFFFFB0FE),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Mulching',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/serviceIcon5.png',
                      containerColorTop: const Color(0xFFFFDFCB),
                      containerColorBottom: const Color(0xFFFD9F67),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Tree Care',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/serviceIcon6.png',
                      containerColorTop: const Color(0xFFB0E5FC),
                      containerColorBottom: const Color(0xFF8DC3DA),
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
                  icon: Image.asset('assets/images/homePressedIcon.png',
                      height: 40, width: 40),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('assets/images/myServicesIcon.png',
                        height: 40, width: 40),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerServicesPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('assets/images/communicationIcon.png',
                      height: 40, width: 40),
                  onPressed: () {

                  },
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('assets/images/moreIcon.png',
                      height: 40, width: 40),
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
              top: -30, // Adjust this value to position the button as needed
              child: Container(
                height: 90, // Increase the height for a larger button
                width: 90, // Increase the width for a larger button
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  color: Color(0xFFBCDD8C), // Background color of the button
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/centerIcon.png',
                    height: 90, // Adjust the size of the inner image/icon
                    width: 90,
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
