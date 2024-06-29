import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/customer_order_details.dart';

import '../pages/services_data.dart';

class CustomerMyServicesCard extends StatefulWidget {
  final order;
  final token;
  final customerId;
  final String statusText;
  final Color statusColor;

  const CustomerMyServicesCard({
    Key? key,
    required this.token,
    required this.customerId,
    required this.order,
    required this.statusText,
    required this.statusColor,
  }) : super(key: key);

  @override
  State<CustomerMyServicesCard> createState() => _CustomerMyServicesCardState();
}

class _CustomerMyServicesCardState extends State<CustomerMyServicesCard> {
  late String imageURL = '';

  void setData(){
    for (var service in servicesData) {
      if (service.containsKey(widget.order.serviceType)) {
        var serviceData = service[widget.order.serviceType];
        setState(() {
          imageURL = serviceData["image_link"];
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

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(children: [
        Card(
          color: const Color(0xFFCEF29B),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.order.serviceType,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF1C1F34),
                      fontSize: fontHelper(context) * 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    child: imageURL.isNotEmpty
                        ? Image(
                      image: AssetImage(imageURL),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: screenWidth(context) * 0.35,
                    )
                        : Icon(
                      Icons.image_not_supported, // Placeholder icon
                      size: 50, // Adjust size as needed
                      color: Colors.grey, // Adjust color as needed
                    ),
                  ),
                ),


                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order!.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order.time,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Provider',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Click 'View Details'",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment mode',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Coming Soon!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      // ListTile(
                      //   title: Text(
                      //     order.serviceType,
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   subtitle: Text(
                      //     order.date,
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerOrderDetailsPage(
                                        token: widget.token,
                                        customerId: widget.customerId,
                                        orderId: widget.order.id,
                                      ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.green[900],
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 69,
          left: 30,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.statusColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.statusText,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontHelper(context) * 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
