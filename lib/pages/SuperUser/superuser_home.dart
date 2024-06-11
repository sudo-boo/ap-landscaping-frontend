import 'package:ap_landscaping/pages/SuperUser/superuser_assign_orders_page.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_providers.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_users.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_profile_page.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_services_page.dart';
import 'package:ap_landscaping/utilities/custom_spacer.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:ap_landscaping/utilities/homepage_stats_card.dart';
import 'package:flutter/material.dart';

import '../../utilities/coming_soon_popup.dart';

// import 'provider_crew_page.dart';

class SuperUserPage extends StatefulWidget {
  final token;
  final superuserId;
  const SuperUserPage({required this.token, required this.superuserId, Key? key})
      : super(key: key);

  @override
  State<SuperUserPage> createState() => _SuperUserPageState();
}

class _SuperUserPageState extends State<SuperUserPage> {
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
        actions: <Widget>[
          IconButton(
            icon: const Image(
              image: AssetImage('assets/images/notificationsIcon.png'),
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
          const SizedBox(height: 20),
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
                  color: Colors.yellow.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Superuser',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
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
                      StatsCard(value: "58", title: "Total Bookings", cardColor: Color(0xF0FFE9E9)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      StatsCard(value: "50", title: "Total Services", cardColor: Color(0xF0ADFABE)),
                    ],
                  ),
                  SizedBox(height: getDims.fractionHeight(0.01)),
                  Row(
                    children: [
                      StatsCard(value: "5", title: "Crew", cardColor: Color(0xF0E5FFDA)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      StatsCard(value: "\$7657", title: "Total Earning", cardColor: Color(0xF0A5DBFF)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          CustomSpacer(height: 3, width: screenWidth(context) * 0.8,),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuperUserAssignServicesPage(token: widget.token, superUserId: widget.superuserId)),
                );
              },
              child: Container(
                width: double.infinity, // Make the button take the full width of its parent
                padding: EdgeInsets.symmetric(vertical: 15), // Padding for height
                decoration: ShapeDecoration(
                  color: Colors.green.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Assign Orders >>',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 18, // Font size
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color(0xFF3E363F),
                  shape: OvalBorder(),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/userIcon.png',
                  ),
                  onPressed: () {},
                ),
              ),
              title: const Text(
                'View All Users',
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
                      builder: (context) => SuperUserAllCustomersPage(
                        superUserId: widget.superuserId,
                        token: widget.token,
                      ),
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Color(0xFF3E363F),
                  shape: OvalBorder(),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/userIcon.png',
                  ),
                  onPressed: () {},
                ),
              ),
              title: const Text(
                'View All Providers',
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
                      builder: (context) => SuperUserAllProvidersPage(
                        superUserId: widget.superuserId,
                        token: widget.token,
                      ),
                    ));
              },
            ),
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
                              builder: (context) => SuperUserServicesPage(
                                  token: widget.token,
                                  superUserId: widget.superuserId
                              )));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('assets/images/communicationIcon.png',
                      height: 35, width: 35),
                  onPressed: () {showComingSoonDialog(context);},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('assets/images/moreIcon.png',
                      height: 35, width: 35),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuperUserProfilePage(
                            token: widget.token, superuserId: widget.superuserId),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

