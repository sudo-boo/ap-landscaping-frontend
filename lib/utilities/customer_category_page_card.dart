import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import '../pages/customer/customer_scheduling_page.dart';

class CategoryPageCard extends StatelessWidget {
  final String serviceName;
  final dynamic token;
  final dynamic customerId;
  final String imageLink;
  final Color containerColorTop;
  final Color containerColorBottom;

  const CategoryPageCard({
    Key? key,
    required this.serviceName,
    required this.token,
    required this.customerId,
    required this.imageLink,
    required this.containerColorTop,
    required this.containerColorBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerSchedulingPage(
              serviceName: serviceName,
              token: token,
              customerId: customerId
          ),
        ),
      );
    },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              width: 150,
              height: 75,
              decoration: ShapeDecoration(
                color: containerColorTop,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imageLink,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 34,
            decoration: ShapeDecoration(
              color: containerColorBottom,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            child: Center(
              child: Text(
                serviceName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontHelper(context) * 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
