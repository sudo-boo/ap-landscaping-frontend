import 'package:flutter/material.dart';
import '../pages/provider/provider_order_details_page.dart';
import '../pages/services_data.dart';
import 'helper_functions.dart';

class ProviderServicesCard extends StatefulWidget {
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
  State<ProviderServicesCard> createState() => _ProviderServicesCardState();
}


class _ProviderServicesCardState extends State<ProviderServicesCard> {
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
                Align(
                  alignment:
                  Alignment.centerLeft,
                  child: Text(
                    widget.order.serviceType,
                    // textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF1C1F34),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight:
                      FontWeight.w600,
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


                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                  const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
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
                            widget.order!.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
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
                            widget.order.time,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
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
                            widget.order.customerName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              height: 0,
                            ),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                            "Coming Soon!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1C1F34),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    ProviderOrderDetailsPage(
                                      token: widget.token,
                                      providerId: widget.providerId,
                                      orderId: widget.order.id,
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
                        ),
                      if (!widget.isAccepted) ...[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: widget.onPress1,
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
                              onPressed: widget.onPress2,
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
              borderRadius:
              BorderRadius.circular(10),
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
