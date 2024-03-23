import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/provider/my_services_page.dart';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';

import '../../utilities/homepage_stats_card.dart';
import 'crew_page.dart';

class ProviderPage extends StatefulWidget {
  final token;
  final providerId;
  const ProviderPage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    Dimensions getDims = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.person), // Profile Icon
        //   onPressed: () {
        //     Navigator.of(context).pushReplacementNamed('/home');
        //   },
        // ),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: getDims.fractionWidth(0.01)),
              child: Container(
                width: getDims.fractionWidth(0.9),
                height: 84,
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 30,
                  right: 30,
                  bottom: 26,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFCEF29B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Provider!!',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(width: getDims.fractionWidth(0.03)),
                    Icon(
                      Icons.settings_suggest,
                      size: 34, // Adjust size as needed
                      color: Colors.blue.shade400,
                    )
                  ],

                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const StatsCard(
                        value: "58",
                        title: "Total Bookings",
                        cardColor: Color(0xFFFFE9E9)
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      const StatsCard(
                          value: "50",
                          title: "Total Services",
                          cardColor: Color(0xFFFDFABE)
                      ),
                    ],
                  ),
                  SizedBox(height: getDims.fractionHeight(0.01)),
                  Row(
                    children: [
                      StatsCard(
                        value: "2",
                        title: "Crew",
                        cardColor: const Color(0xFFE5FFDA),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => crewPage(
                                token: widget.token, providerId: widget.providerId
                              )
                            )
                          );
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      const StatsCard(
                        value: "\$7657",
                        title: "Total Earning",
                        cardColor: Color(0xFFE5DBFF)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  providerId: widget.providerId)));
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(
                            token: widget.token, providerId: widget.providerId),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

