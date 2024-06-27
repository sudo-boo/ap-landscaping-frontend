import 'package:ap_landscaping/pages/SuperUser/superuser_home.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_profile_page.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_services_page.dart';
import 'package:flutter/material.dart';

import '../../utilities/coming_soon_popup.dart';


class SuperUserMain extends StatefulWidget {
  final String token;
  final String superuserId;

  const SuperUserMain({required this.token, required this.superuserId, Key? key})
      : super(key: key);

  @override
  State<SuperUserMain> createState() => _SuperUserMainState();
}

class _SuperUserMainState extends State<SuperUserMain> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      SuperUserHomePage(token: widget.token, superuserId: widget.superuserId),
      SuperUserServicesPage(token: widget.token, superUserId: widget.superuserId),
      const ComingSoonPage(),
      const ComingSoonPage(),
      SuperUserProfilePage(token: widget.token, superuserId: widget.superuserId),
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
