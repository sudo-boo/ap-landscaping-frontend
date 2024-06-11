import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';

import '../pages/SuperUser/superuser_order_details_page.dart';
import '../pages/services_data.dart';

class SuperUserServicesCard extends StatefulWidget {
  final order;
  final token;
  final superUserId;
  final String statusText;
  final Color statusColor;
  final VoidCallback? onPressed;

  const SuperUserServicesCard({
    Key? key,
    required this.token,
    required this.superUserId,
    required this.order,
    required this.statusText,
    required this.statusColor,
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
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
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
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 8,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Provider ID',
                      //       style: TextStyle(
                      //         color:
                      //         Color(0xFF1C1F34),
                      //         fontSize: fontHelper(context) * 12,
                      //         fontFamily: 'Inter',
                      //         fontWeight:
                      //         FontWeight.w600,
                      //         height: 0,
                      //       ),
                      //     ),
                      //     Text(
                      //       widget.order.providerId,
                      //       textAlign:
                      //       TextAlign.center,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Container(
                      //   width: double.maxFinite,
                      //   height: 1,
                      //   decoration: ShapeDecoration(
                      //     color: const Color(0xFF3E363F),
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: fontHelper(context) * 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(width: 10), // Add some spacing between the label and address
                          Flexible(
                            flex: 7,
                            child: Text(
                              widget.order.address,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              softWrap: true, // Ensures text wraps to the next line
                            ),
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
                          color: const Color(0xFF3E363F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
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
                                    SuperUserOrderDetailsPage(
                                      token: widget.token,
                                      superUserId: widget.superUserId,
                                      orderId: widget.order.id,
                                      statusText: widget.statusText,
                                      statusColor: widget.statusColor,
                                    ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF24730B),
                            ),
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter'
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.order.providerId == 'NA' && !widget.order.isCancelled) Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: widget.onPressed,
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFA687FF),
                            ),
                            child: const Text(
                              'Assign',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter'
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
