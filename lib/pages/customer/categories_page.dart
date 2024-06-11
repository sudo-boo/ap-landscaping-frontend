import 'package:ap_landscaping/pages/customer/customer_my_services_page.dart';
import 'package:ap_landscaping/pages/customer/customer_profile_page.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../utilities/coming_soon_popup.dart';
import '../../utilities/customer_category_page_card.dart';


class ServicesCategoriesPage extends StatefulWidget {
  final token;
  final customerId;
  const ServicesCategoriesPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<ServicesCategoriesPage> createState() => _ServicesCategoriesState();
}

class _ServicesCategoriesState extends State<ServicesCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: fontHelper(context) * 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        leading: IconButton(
            icon: const Image(
              image: AssetImage('assets/images/backIcon.png'),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        // backgroundColor: Colors.green[900],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 0,
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        // physics:
        //     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        children: <Widget>[
          CategoryPageCard(
            serviceName: 'Lawn Treatment',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon1.png',
            containerColorTop: const Color(0xFFFFE9E9),
            containerColorBottom: const Color(0xFFFFBBC1),
          ),
          CategoryPageCard(
            serviceName: 'Leaf Removal',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon2.png',
            containerColorTop: const Color(0xFF96C257),
            containerColorBottom: const Color(0xFF96C257),
          ),
          CategoryPageCard(
            serviceName: 'Landscaping',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon3.png',
            containerColorTop: const Color(0xFFFDFABE),
            containerColorBottom: const Color(0xFFF4D376),
          ),
          CategoryPageCard(
            serviceName: 'Bush Trimming',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon4.png',
            containerColorTop: const Color(0xFFFEDCFD),
            containerColorBottom: const Color(0xFFFFB0FE),
          ),
          CategoryPageCard(
            serviceName: 'Mulching',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon5.png',
            containerColorTop: const Color(0xFFFFDFCB),
            containerColorBottom: const Color(0xFFFD9F67),
          ),
          CategoryPageCard(
            serviceName: 'Tree Care',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon6.png',
            containerColorTop: const Color(0xFFB0E5FC),
            containerColorBottom: const Color(0xFF8DC3DA),
          ),
          CategoryPageCard(
            serviceName: 'Customize',
            token: widget.token,
            customerId: widget.customerId,
            imageLink: 'assets/images/serviceIcon4.png',
            containerColorTop: const Color(0xFFB0E5FC),
            containerColorBottom: const Color(0xFF8DC3DA),
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
                  icon: Image.asset('assets/images/homePressedIcon.png',
                      height: 35, width: 35),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('assets/images/myServicesIcon.png',
                        height: 35, width: 35),
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
                      height: 35, width: 35),
                  onPressed: () {
                    showComingSoonDialog(context);
                  },
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('assets/images/moreIcon.png',
                      height: 35, width: 35),
                  onPressed: () {
                    Navigator.pushReplacement(
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
                    'assets/images/centerIcon.png',
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

