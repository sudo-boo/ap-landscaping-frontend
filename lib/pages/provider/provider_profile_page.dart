import 'package:ap_landscaping/pages/my_home_page.dart';
import 'package:ap_landscaping/pages/provider/provider_update_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../utilities/helper_functions.dart';

class ProviderProfilePage extends StatefulWidget {
  final token;
  final providerId;
  const ProviderProfilePage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<ProviderProfilePage> createState() => _ProviderProfilePageState();
}

class _ProviderProfilePageState extends State<ProviderProfilePage> {
  String username = '';

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
                    logoutProvider();
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
                    style: TextStyle(fontSize: 18.0),
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
                      fontSize: 18.0,
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

  Future<void> getUsernameFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('name') ?? ''; // Retrieve username from shared preferences
      });
    } catch (e) {
      // print('Error retrieving username: $e');
    }
  }

  Future<void> logoutProvider() async {
    var url = Uri.parse(providerLogout); // Replace with your actual endpoint
    try {
      // print(widget.token);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}', // Include the token in the header
        },
      );

      if (response.statusCode == 200) {
        // print('Logout successful');
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
        // print(response.statusCode);
        // print(response['error']);
        // print(json.decode(response.body)['error']);
        // print('Failed to logout');
        // Handle error response
      }
    } catch (e) {
      // print('Error during logout: $e');
      // Handle any exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    getUsernameFromSharedPreferences();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
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
      ),

      body: Container(
        color: const Color(0xFFBBE1C5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: const Color(0xFFFDFABE),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderUpdateProfileInfoPage(
                                token: widget.token,
                                providerId: widget.providerId
                              )
                            )
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF3E363F),
                              shape: CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.perm_identity_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            username,
                            style: const TextStyle(
                              color: Color(0xFF181D27),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0.12,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                          child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                            ),
                        ),
                        title: Text(
                          'Sign out',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: fontHelper(context) * 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
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
    );
  }
}
