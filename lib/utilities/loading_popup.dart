import 'package:flutter/material.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text(
          "Please wait...",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            letterSpacing: 0,
            height: 0,
          ),
        ),
        content: SizedBox(
          width: 50.0, // Example width
          height: 50.0, // Example height
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}