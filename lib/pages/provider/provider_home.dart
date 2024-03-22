import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/provider/my_services_page.dart';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';

import 'crew_page.dart';

class providerPage extends StatefulWidget {
  final token;
  final providerId;
  const providerPage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<providerPage> createState() => _providerPageState();
}

class _providerPageState extends State<providerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.person), // Profile Icon
        //   onPressed: () {
        //     Navigator.of(context).pushReplacementNamed('/home');
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: const Image(
              image: AssetImage('lib/assets/images/notificationsIcon.png'),
            ), // Notifications Bell Icon
            onPressed: () {
              // Handle notifications icon action (e.g., show notifications)
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 200,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => crewPage(
                          token: widget.token, providerId: widget.providerId)));
            },
            child: Card(
              color: const Color.fromRGBO(229, 255, 218, 1),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Crew'),
                    IconButton(
                      icon: const Image(
                        image: AssetImage('lib/assets/images/crewPageIcon.png'),
                      ),
                      onPressed: () {},
                      // onPressed: () {}
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none, // Allows the child to overflow the stack
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Image.asset('lib/assets/images/homePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  providerId: widget.providerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('lib/assets/images/communicationIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/images/moreIcon.png',
                      height: 45, width: 45),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profilePage(
                            token: widget.token, providerId: widget.providerId),
                      ),
                    );
                  },
                  // onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
            Positioned(
              top: -35, // Adjust this value to position the button as needed
              child: Container(
                height: 100, // Increase the height for a larger button
                width: 100, // Increase the width for a larger button
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  color: Color(0xFFBCDD8C), // Background color of the button
                ),
                child: IconButton(
                  icon: Image.asset(
                    'lib/assets/images/centerIcon.png',
                    height: 100, // Adjust the size of the inner image/icon
                    width: 100,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

