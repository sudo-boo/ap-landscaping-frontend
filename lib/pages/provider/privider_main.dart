import 'package:ap_landscaping/pages/provider/provider_home.dart';
import 'package:ap_landscaping/pages/provider/provider_my_services_page.dart';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';
import 'package:flutter/material.dart';
import '../../utilities/coming_soon_popup.dart';


class ProviderMain extends StatefulWidget {
  final String token;
  final String providerId;

  const ProviderMain({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<ProviderMain> createState() => _ProviderMainState();
}

class _ProviderMainState extends State<ProviderMain> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      ProviderHomePage(token: widget.token, providerId: widget.providerId),
      ProviderMyServicesPage(token: widget.token, providerId: widget.providerId),
      const ComingSoonPage(),
      const ComingSoonPage(),
      ProviderProfilePage(token: widget.token, providerId: widget.providerId),
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
