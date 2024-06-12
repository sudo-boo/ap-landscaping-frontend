import 'dart:convert';
import 'package:ap_landscaping/utilities/customer_home_category_card.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/customer_my_services_page.dart';
import 'package:ap_landscaping/pages/customer/customer_profile_page.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../models/customerinfo.dart';
import 'package:ap_landscaping/utilities/coming_soon_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_order_success_page.dart';

class CustomerHomePage extends StatefulWidget {
  final token;
  final customerId;
  const CustomerHomePage({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // height: screenHeight(context),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: screenWidth(context) * 2, // Set your desired width
                // height: screenHeight(context)*0.45, // Set your desired height
                decoration: BoxDecoration(
                  color: Color(0xFF73A580),
                  borderRadius: BorderRadius.only(// Top-right corner radius
                    bottomLeft: Radius.elliptical(200, 50), // Bottom-left corner radius
                    bottomRight: Radius.elliptical(200, 50), // Bottom-right corner radius
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight(context)*0.08,),
                    Image(
                      image: AssetImage('assets/images/homeScreen.png',),
                      height: screenHeight(context) * 0.3,
                    ),
                    SizedBox(height: screenHeight(context)*0.03,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Welcome Customer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontHelper(context) * 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 2,
                    width: screenWidth(context) * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  // SizedBox(width: screenWidth(context) * 0.1,),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: screenWidth(context) * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text(
                'Services',
                style: TextStyle(
                  color: Color(0xFF3E363F),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    HomePageCategoryCard(
                      serviceName: 'Lawn Care',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/lawn-care-icon.png',
                      containerColorTop: const Color(0xFFFFE9E9),
                      containerColorBottom: const Color(0xFFFFBBC1),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Junk Removal',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/junk-removal-icon.png',
                      containerColorTop: const Color(0xFFFAE957),
                      containerColorBottom: const Color(0xFFFAD957),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Donation Pickup',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/donation-pickup-icon.png',
                      containerColorTop: const Color(0xFFFDFABE),
                      containerColorBottom: const Color(0xFFF4D376),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Power Washing',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/power-washing-icon.png',
                      containerColorTop: const Color(0xFFFEDCFD),
                      containerColorBottom: const Color(0xFFFFB0FE),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Mulching',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/mulching-icon.png',
                      containerColorTop: const Color(0xFFFFDFCB),
                      containerColorBottom: const Color(0xFFFD9F67),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Tree Care',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/tree-care-icon.png',
                      containerColorTop: const Color(0xFFB0E5FC),
                      containerColorBottom: const Color(0xFF8DC3DA),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Moving Service',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'assets/images/moving-services-icon.png',
                      containerColorTop: const Color(0xFFB0E5FC),
                      containerColorBottom: const Color(0xFF8DC3DA),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                    showComingSoonDialog(context);
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
