import 'package:ap_landscaping/pages/customer/customer_home_page.dart';
import 'package:ap_landscaping/pages/customer/customer_my_services_page.dart';
import 'package:ap_landscaping/pages/customer/customer_profile_page.dart';
import 'package:ap_landscaping/utilities/coming_soon_popup.dart';
import 'package:flutter/material.dart';

class CustomerMain extends StatefulWidget {
  final String token;
  final String customerId;

  const CustomerMain({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<CustomerMain> createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      CustomerHomePage(token: widget.token, customerId: widget.customerId),
      CustomerServicesPage(token: widget.token, customerId: widget.customerId),
      const ComingSoonPage(),
      const ComingSoonPage(),
      CustomerProfilePage(token: widget.token, customerId: widget.customerId),
    ];
    return Scaffold(
      body: widgetList[myIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.green.shade900,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                  size: 40,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  size: 40,
                ),
                label: "Services",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_outlined,
                  size: 0,
                ),
                label: "Center",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_rounded,
                  size: 40,
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_rounded,
                  size: 40,
                ),
                label: "Menu",
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 90,
        height: 90,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {},
          elevation: 0.0,
          child: IconButton(
            icon: Image.asset(
              'assets/images/centerIcon.png',
              height: 80,
              width: 80,
            ),
            onPressed: () {
              setState(() {
                myIndex = 2;
              });
            },
          ),
        ),
      ),
    );
  }
}
