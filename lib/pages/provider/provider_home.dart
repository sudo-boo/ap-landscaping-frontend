import 'dart:convert';

import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/provider/provider_my_services_page.dart';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utilities/coming_soon_popup.dart';
import '../../utilities/homepage_stats_card.dart';
import 'provider_crew_page.dart';

class ProviderPage extends StatefulWidget {
  final token;
  final providerId;
  const ProviderPage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  providerInfo providerInfo1 = providerInfo();

  Future<void> fetchAndSaveProviderInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the name is null in SharedPreferences
    String? savedName = prefs.getString('name');
    if (savedName == null) {
      final url = Uri.parse(providerProfileInfo); // Replace with your API URL
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
            providerInfo1.username = data['provider']['username'] ?? '';
            // print(providerInfo1.username);
            // Other assignments...
          });

          await prefs.setString('name', providerInfo1.username);
          // print('Username set in SharedPreferences: ${providerInfo1.username}');
        } else {
          // print('Failed to fetch customer info');
        }
      } catch (e) {
        // print('Error: $e');
      }
    } else {
      // print('Name already exists in SharedPreferences: $savedName');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAndSaveProviderInfo();
  }

  Widget build(BuildContext context) {
    Dimensions getDims = Dimensions(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: screenHeight(context)*0.07),
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
                      blurRadius: 1,
                      offset: Offset(0, 1),
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
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(width: getDims.fractionWidth(0.03)),
                    Icon(
                      Icons.settings_suggest,
                      size: 30, // Adjust size as needed
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
                  SizedBox(height: 10),
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
    );
  }
}

