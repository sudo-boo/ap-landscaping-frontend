import 'package:flutter/material.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';

class CustomSpacer extends StatelessWidget {
  final double width;
  final double height;
  final double padding;

  const CustomSpacer({
    Key? key,
    this.width = double.infinity,
    this.height = 1,
    this.padding = 2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
