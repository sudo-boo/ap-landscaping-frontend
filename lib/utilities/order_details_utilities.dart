import 'package:flutter/material.dart';
import '../models/orderinfo.dart';
import '../pages/services_data.dart';
import 'helper_functions.dart';

class OrderDetailsUtilityWidgets extends StatelessWidget {
  final orderInfo order;

  const OrderDetailsUtilityWidgets({
    super.key,
    required this.order
  });

  Widget buildPriceDetails(BuildContext context) {
    var serviceType = order.serviceType;
    var service = servicesData.firstWhere((service) => service.containsKey(serviceType)).values.first;
    var price = service['price'];
    var offer = service['offer'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                "Price Details : ",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fontHelper(context) * 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFFCFF29B),
                borderRadius: BorderRadius.circular(20),
              ),
              // child: Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Price: ",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 16,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         Text(
              //           "\$${price}",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 16,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Offer: ",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 16,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         Text(
              //           "$offer% off",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 16,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 4), // CustomSpacer replacement
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Total Amount: ",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 17,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w900,
              //           ),
              //         ),
              //         Text(
              //           "\$${price}",
              //           style: TextStyle(
              //             color: Color(0xFF3E363F),
              //             fontSize: fontHelper(context) * 17,
              //             fontFamily: 'Inter',
              //             fontWeight: FontWeight.w900,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              child: Text(
                "Prices will be decided based on numerous factors.",
                style: TextStyle(
                  color: Color(0xFF3E363F),
                  fontSize: fontHelper(context) * 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDurationWidget(BuildContext context) {
    var serviceType = order.serviceType;
    var service = servicesData.firstWhere((service) => service.containsKey(serviceType)).values.first;
    var duration = service['time'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
      child: Column(
        children: <Widget>[
          ListTile(
            // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                "Duration : ",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: fontHelper(context) * 22,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            subtitle: Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service Time: ",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: fontHelper(context) * 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    duration,
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: fontHelper(context) * 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}