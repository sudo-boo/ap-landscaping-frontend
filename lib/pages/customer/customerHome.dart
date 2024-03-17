import 'package:ap_landscaping/utilities/customer_home_category_card.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/categories_page.dart';
import 'package:ap_landscaping/pages/customer/my_services_page.dart';
import 'package:ap_landscaping/pages/customer/profile_page.dart';
import 'package:ap_landscaping/pages/customer/scheduling_page.dart';

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
                    HomePageCategoryCard(
                        serviceName: 'Lawn Treatment',
                        token: widget.token,
                        customerId: widget.customerId,
                        imageLink: 'lib/assets/images/serviceIcon1.png',
                        containerColorTop: const Color(0xFFFFE9E9),
                        containerColorBottom: const Color(0xFFFFBBC1),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Leaf Removal',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'lib/assets/images/serviceIcon2.png',
                      containerColorTop: const Color(0xFF96C257),
                      containerColorBottom: const Color(0xFF96C257),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Landscaping',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'lib/assets/images/serviceIcon3.png',
                      containerColorTop: const Color(0xFFFDFABE),
                      containerColorBottom: const Color(0xFFF4D376),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Bush Trimming',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'lib/assets/images/serviceIcon4.png',
                      containerColorTop: const Color(0xFFFEDCFD),
                      containerColorBottom: const Color(0xFFFFB0FE),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Mulching',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'lib/assets/images/serviceIcon5.png',
                      containerColorTop: const Color(0xFFFFDFCB),
                      containerColorBottom: const Color(0xFFFD9F67),
                    ),
                    HomePageCategoryCard(
                      serviceName: 'Tree Care',
                      token: widget.token,
                      customerId: widget.customerId,
                      imageLink: 'lib/assets/images/serviceIcon6.png',
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
