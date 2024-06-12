import 'dart:convert';

import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_providers.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_users.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_home.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_services_page.dart';
import 'package:ap_landscaping/pages/my_home_page.dart';
// import 'package:ap_landscaping/pages/provider/customer_my_services_page.dart';
// import 'package:ap_landscaping/pages/provider/provider_home.dart';
// import 'package:ap_landscaping/pages/provider/provider_update_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../utilities/coming_soon_popup.dart';

class SuperUserProfilePage extends StatefulWidget {
  final token;
  final superuserId;
  const SuperUserProfilePage({required this.token, required this.superuserId, Key? key})
      : super(key: key);

  @override
  State<SuperUserProfilePage> createState() => _SuperUserProfilePageState();
}

class _SuperUserProfilePageState extends State<SuperUserProfilePage> {
  void showCustomSignOutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: Text(
                  "Are you sure you want to sign out?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign out logic
                    logoutSuperUser();
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFA686FF), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Sign out",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFA686FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> logoutSuperUser() async {
    var url = Uri.parse(superUserLogout);
    try {
      print(widget.token);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        print('Logout successful');
        await SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
          prefs.remove('profileType');
          prefs.remove('id');
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                title: 'AP Landscaping',
              )),
              (Route<dynamic> route) => false,
        );
        // Handle successful logout
      } else {
        print(response.statusCode);
        // print(response['error']);
        print(json.decode(response.body)['error']);
        print('Failed to logout');
        // Handle error response
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle any exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
      body: Container(
        color: const Color(0xFFBBE1C5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.yellow.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Increased border radius for more rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFC8B88A),
                          shape: OvalBorder(),
                        ),
                        child: Icon(Icons.person), // Added color to the icon for better visibility
                      ),
                      title: const Text(
                        'Super User',
                        style: TextStyle(
                          color: Color(0xFF181D27),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.5, // Adjusted height for better text alignment
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Increased border radius for more rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Colors.pink.shade100,
                            shape: CircleBorder(),
                          ),
                          child: Icon(Icons.logout_rounded),
                        ),
                        title: const Text(
                          'Sign out',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // logoutprovider();
                          //  Navigator.of(context).pushReplacementNamed('/home');
                          // print(widget.token);
                          showCustomSignOutBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('assets/images/homeIcon.png',
                      height: 35, width: 35),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => SuperUserPage(
                          token: widget.token,
                          superuserId: widget.superuserId)
                      ),
                        (Route<dynamic> route) => false,
                    );
                  },
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
                                  superUserId: widget.superuserId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('assets/images/communicationIcon.png',
                      height: 35, width: 35),
                  onPressed: () {showComingSoonDialog(context);},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('assets/images/morePressedIcon.png',
                      height: 35, width: 35),
                  onPressed: () {},
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
