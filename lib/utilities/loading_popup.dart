import 'package:flutter/material.dart';

class LoadingPopUp extends StatefulWidget {
  final Key? key;

  const LoadingPopUp({this.key}) : super(key: key);

  @override
  _LoadingPopUpState createState() => _LoadingPopUpState();

  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return LoadingPopUp();
      },
    );
  }
}

class _LoadingPopUpState extends State<LoadingPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 50.0, // Example width
        height: 50.0, // Example height
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
