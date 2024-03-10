import 'package:flutter/material.dart';
//
class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});
  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('AP Landscaping'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 250),
          const Text(
              'Congratulations you have been successfully registered!!\nPlease verify your email before logging in\nTo do so an email is sent to you,Click the verify button on it.'),
          const SizedBox(height: 75),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/customersignin');
            },
            child:
            const Text('Go to Login Page', style: TextStyle(fontSize: 18)),
          )
        ]),
      ),
    );
  }
}