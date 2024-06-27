import 'package:ap_landscaping/pages/SuperUser/superuser_assign_orders_page.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_providers.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_users.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:ap_landscaping/utilities/homepage_stats_card.dart';
import 'package:flutter/material.dart';

class SuperUserHomePage extends StatefulWidget {
  final token;
  final superuserId;
  const SuperUserHomePage({required this.token, required this.superuserId, Key? key})
      : super(key: key);

  @override
  State<SuperUserHomePage> createState() => _SuperUserHomePageState();
}

class _SuperUserHomePageState extends State<SuperUserHomePage> {
  @override
  Widget build(BuildContext context) {
    Dimensions getDims = Dimensions(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight(context)*0.07,),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: getDims.fractionWidth(0.01)),
                child: Container(
                  width: getDims.fractionWidth(0.9),
                  height: 60,
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
                        'Welcome Superuser!!',
                        style: TextStyle(
                          color: Color(0xFF3E363F),
                          fontSize: 18,
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
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF3E363F),
                    shape: OvalBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_3_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                title: const Text(
                  'View All Users',
                  style: TextStyle(
                    color: Color(0xFF181D27),
                    fontSize: 15,
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF3E363F),
                    shape: OvalBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_3_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                title: const Text(
                  'View All Providers',
                  style: TextStyle(
                    color: Color(0xFF181D27),
                    fontSize: 14,
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
                        fontSize: 16, // Font size
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
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

