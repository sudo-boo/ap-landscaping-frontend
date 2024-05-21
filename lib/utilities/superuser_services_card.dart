import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/customer_order_details.dart';

import '../pages/services_data.dart';

class SuperUserServicesCard extends StatefulWidget {
  final order;
  final token;
  final superUserId;
  final VoidCallback? onPressed;

  const SuperUserServicesCard({
    Key? key,
    required this.token,
    required this.superUserId,
    required this.order,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SuperUserServicesCard> createState() => _SuperUserServicesCardState();
}

class _SuperUserServicesCardState extends State<SuperUserServicesCard> {
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

  @override
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.order.serviceType,
                          style: TextStyle(
                            color: Color(0xFF1C1F34),
                            fontSize: fontHelper(context) * 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.order.orderId,
                      style: TextStyle(
                        color: Color(0xFF1C1F34),
                        fontSize: fontHelper(context) * 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 12,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order!.date,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color:
                          const Color(0xFF3E363F),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 12,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order.time,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color:
                          const Color(0xFF3E363F),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'Provider',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 12,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order.providerName,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color:
                          const Color(0xFF3E363F),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 12,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order.address,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                            onPressed: widget.onPressed,

                              // () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         CustomerOrderDetailsPage(
                              //           token: widget.token,
                              //           customerId: widget.customerId,
                              //           orderId: widget.order.id,
                              //         ),
                              //   ),
                              // );
                              // }

                              style: ElevatedButton
                                .styleFrom(
                              backgroundColor: Color(0xFFA687FF),
                            ),
                            child: const Text(
                              'Assign',
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
      ]),
    );
  }
}
