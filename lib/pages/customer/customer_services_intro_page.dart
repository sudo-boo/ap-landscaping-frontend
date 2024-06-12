import 'package:flutter/material.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:ap_landscaping/pages/services_data.dart';

import 'customer_scheduling_page.dart';

class CustomerServicesInfoPage extends StatefulWidget {
  final token;
  final customerId;
  final String serviceName;

  const CustomerServicesInfoPage({
    required this.token,
    required this.customerId,
    required this.serviceName,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerServicesInfoPage> createState() =>
      _CustomerServicesInfoPageState();
}

class _CustomerServicesInfoPageState extends State<CustomerServicesInfoPage> {
  String imageURL = "";
  String description = "";
  String time = "";
  double offer = 0.0;
  double price = 0.0;
  double rating = 5.0;

  void setData() {
    for (var service in servicesData) {
      if (service.containsKey(widget.serviceName)) {
        var serviceData = service[widget.serviceName];
        setState(() {
          imageURL = serviceData["image_link"];
          description = serviceData["description"];
          time = serviceData["time"];
          price = serviceData["price"];
          offer = serviceData["offer"];
          rating = serviceData["rating"];
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image(
                    image: AssetImage(imageURL),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE1E1),
                      borderRadius: BorderRadius.circular(20.0), // Rounded corners
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
                      children: [
                        Text(
                          widget.serviceName,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: fontHelper(context) * 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order hold fee: ",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: fontHelper(context) * 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3E363F)
                              ),
                            ),
                            Text(
                              "\$$price",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: fontHelper(context) * 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xDD3E363F),
                                  height: 0
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Please note that pricing is subject to variation based on several factors.\nWe will contact you with further details.\n*Hold fee is included in the actual pricing and refunded if cancelled.",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: fontHelper(context) * 12.0,
                                    // fontWeight: FontWeight.w600,
                                    color: Color(0xFF3E363F)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Duration : ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fontHelper(context) * 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3E363F),
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fontHelper(context) * 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0x993E363F),
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rating : ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fontHelper(context) * 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3E363F),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.orangeAccent,
                                ),
                                Text(
                                  "$rating",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: fontHelper(context) * 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0x993E363F),
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenHeight(context) * 0.03, 20, screenHeight(context) * 0.03, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: Color(0xFF3E363F),
                          fontSize: fontHelper(context) * 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        description,
                        // textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xFF3E363F),
                          fontSize: fontHelper(context) * 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerSchedulingPage(
                                    serviceName: widget.serviceName,
                                    token: widget.token,
                                    customerId: widget.customerId
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFA686FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.07,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   top: MediaQuery.of(context).size.height * 0.35,
            //   left: MediaQuery.of(context).size.width * 0.075,
            //   child:
            // ),

            Positioned(
              top: screenHeight(context) * (0.05),
              left: screenWidth(context) * (0.02),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Navigate back when button is pressed
                },
                backgroundColor: Colors.transparent, // Button background color
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, // Icon color
                  size: screenWidth(context) * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
