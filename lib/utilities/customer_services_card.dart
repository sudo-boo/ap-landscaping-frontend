import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/order_details.dart';

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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.order.serviceType,
                    // textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF1C1F34),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                      24.0, 40.0, 24.0, 24.0),
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
                          const Text(
                            'Date',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: 14,
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
                          const Text(
                            'Time',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: 14,
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
                          const Text(
                            'Provider',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: 14,
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
                          const Text(
                            'Payment mode',
                            style: TextStyle(
                              color:
                              Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight:
                              FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.order.providerId,
                            textAlign:
                            TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailsPage(
                                        token: widget.token,
                                        customerId: widget.customerId,
                                        orderId: widget.order.id,
                                      ),
                                ),
                              );
                            },
                            style: ElevatedButton
                                .styleFrom(
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
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
