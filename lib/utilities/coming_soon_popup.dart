import 'package:flutter/material.dart';

class ComingSoonPopUp extends StatelessWidget {
  const ComingSoonPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Coming Soon!',
        style: TextStyle(
          color: Colors.green,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      content: const Text(
        'This feature is coming soon. Stay tuned!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          height: 1.2,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Close',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Inter',
              height: 1.2,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ComingSoonPopUp();
    },
  );
}


class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Feature Coming Soon...',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28
              ),
            ),
            const SizedBox(height: 30),
            // Replace this with your own GIF path
            Image.asset("assets/images/coming-soon.gif"),
            const SizedBox(height: 30),
            const Text(
              'Stay Tuned!!',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24
              ),
            ),
          ],
        ),
      ),
    );
  }
}
