import 'package:flutter/material.dart';

import '../pages/provider/provider_order_details_page.dart';

import 'package:flutter/material.dart';

class ProviderServicesCard extends StatelessWidget {
  final dynamic order;
  final token;
  final providerId;
  final String statusText;
  final Color statusColor;
  final bool isAccepted;
  final VoidCallback? onPress1;
  final VoidCallback? onPress2;

  const ProviderServicesCard({
    Key? key,
    required this.token,
    required this.providerId,
    required this.order,
    required this.statusText,
    required this.statusColor,
    this.isAccepted = true,
    this.onPress1,
    this.onPress2,
  }) : super(key: key);

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
                  alignment:
                  Alignment.centerLeft,
                  child: Text(
                    order.serviceType,
                    // textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF1C1F34),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight:
                      FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                  const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            order!.date,
                            textAlign: TextAlign.center,
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
                          const Text(
                            'Time',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            order.time,
                            textAlign: TextAlign.center,
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
                          const Text(
                            'Customer',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            order.customerName,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        decoration:
                        ShapeDecoration(
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
                          const Text(
                            'Payment mode',
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            order.providerId!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      (isAccepted)
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      ProviderOrderDetailsPage(
                                        token: token,
                                        providerId: providerId,
                                        orderId: order.id,
                                      ),
                                    ),
                                  );
                                },
                                style:
                                ElevatedButton.styleFrom(
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
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: onPress1,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 144, 90, 219),
                                ),
                                child: const Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: onPress2,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Decline',
                                  style: TextStyle(
                                    color: Colors.black,
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
              color: statusColor,
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Text(
              statusText,
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
