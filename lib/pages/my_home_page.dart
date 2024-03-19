import 'package:ap_landscaping/pages/welcome_scroll_pages.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller =
  PageController(viewportFraction: 1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              controller: _controller,
              children: const <Widget>[
                FirstScrollPage(),
                SecondScrollPage(),
                ThirdScrollPage(),
                FourthScrollPage(),
              ],
            ),
            Positioned(
              top: 70, // Adjust the position as needed
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: const WormEffect(
                  activeDotColor: Color(0xFF4E3321),
                  // dotColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
