import 'package:ap_landscaping/customerHome.dart';
import 'package:ap_landscaping/providerHome.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './customerlogin.dart';
import './providerlogin.dart';
import './customersignup.dart';
import './providersignup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
    userOrProvider: prefs.getString('userOrProvider'),
    id: prefs.getString('id'),
  ));
}

class MyApp extends StatelessWidget {
  final userOrProvider;
  final token;
  final id;
  const MyApp(
      {@required this.token,
      Key? key,
      required this.userOrProvider,
      required this.id})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget homeWidget;
    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired) {
        homeWidget = const MyHomePage(title: 'AP Landscaping');
      } else {
        if (userOrProvider == 'user') {
          homeWidget = customerPage(token: token, customerId: id);
        } else if (userOrProvider == 'provider') {
          homeWidget = providerPage(token: token, providerId: id);
        } else {
          homeWidget = const MyHomePage(title: 'AP Landscaping');
        }
      }
    } else {
      homeWidget = const MyHomePage(title: 'AP Landscaping');
    }

    return MaterialApp(
      title: 'AP Landscaping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routes: {
        '/home': (BuildContext ctx) =>
            const MyHomePage(title: 'AP Landscaping'),
        '/customersignin': (BuildContext ctx) => const CustomerSignIn(),
        '/providersignin': (BuildContext ctx) => const ProviderSignIn(),
        '/customersignup': (BuildContext ctx) => const CustomerSignUp(),
        '/providersignup': (BuildContext ctx) => const ProviderSignUp(),
      },
      home: homeWidget,
    );
  }
}

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
              children: <Widget>[
                Container(
                  color: const Color(0xFFF1DDDF),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 0,
                        top: 70,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage1cloud1.png'),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        top: 60,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage1cloud2.png'),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        top: 300,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage1cloud3.png'),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        top: 200,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage1cloud4.png'),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 50,
                        child: Image(
                          image:
                              AssetImage('lib/assets/images/welcomePage1.png'),
                        ),
                      ),
                      Positioned(
                        left: -280,
                        right: -280,
                        top: 540,
                        child: Container(
                            width: 960,
                            height: 960,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1234),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 38,
                                  offset: Offset(0, -17),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0A4B3425),
                                  blurRadius: 69,
                                  offset: Offset(0, -69),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x074B3425),
                                  blurRadius: 93,
                                  offset: Offset(0, -154),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x024B3425),
                                  blurRadius: 110,
                                  offset: Offset(0, -274),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x004B3425),
                                  blurRadius: 120,
                                  offset: Offset(0, -428),
                                  spreadRadius: 0,
                                )
                              ],
                            )),
                      ),
                      // Positioned(
                      //   child: ,
                      // )
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFC8B88A),
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 50,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage2vector1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 270,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage2rainbow.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 100,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage2brain.png'),
                        ),
                      ),
                      Positioned(
                        left: -280,
                        right: -280,
                        top: 540,
                        child: Container(
                            width: 960,
                            height: 960,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1234),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 38,
                                  offset: Offset(0, -17),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0A4B3425),
                                  blurRadius: 69,
                                  offset: Offset(0, -69),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x074B3425),
                                  blurRadius: 93,
                                  offset: Offset(0, -154),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x024B3425),
                                  blurRadius: 110,
                                  offset: Offset(0, -274),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x004B3425),
                                  blurRadius: 120,
                                  offset: Offset(0, -428),
                                  spreadRadius: 0,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFF86B049),
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Image(
                          image: AssetImage(
                              'lib/assets/images/welcomePage3group1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 120,
                        child: Image(
                          image:
                              AssetImage('lib/assets/images/welcomePage3.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        left: -280,
                        right: -280,
                        top: 540,
                        child: Container(
                            width: 960,
                            height: 960,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1234),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0C4B3425),
                                  blurRadius: 38,
                                  offset: Offset(0, -17),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x0A4B3425),
                                  blurRadius: 69,
                                  offset: Offset(0, -69),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x074B3425),
                                  blurRadius: 93,
                                  offset: Offset(0, -154),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x024B3425),
                                  blurRadius: 110,
                                  offset: Offset(0, -274),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x004B3425),
                                  blurRadius: 120,
                                  offset: Offset(0, -428),
                                  spreadRadius: 0,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFC7ECD1),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Positioned(
                        left: 0,
                        top: 100,
                        child: Image(
                          image:
                              AssetImage('lib/assets/images/startPageRect.png'),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 35,
                        top: 100,
                        child: Image(
                          image: AssetImage('lib/assets/images/startPage.png'),
                        ),
                      ),
                      const Positioned(
                        left: 50,
                        right: 50,
                        top: 550,
                        child: SizedBox(
                          child: Text(
                            "Would you like to register as a customer seeking landscaping services, or as a service provider offering your landscaping expertise?",
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              // height: 0.08,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        right: 70,
                        top: 700,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color(0xFF3E363F), // Text color
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/customersignin');
                              },
                              child: const Text('Customer',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.30,
                                  )),
                            ),
                            // const SizedBox(width: 100,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color(0xFF3E363F), // Text color
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/providersignin');
                              },
                              child: const Text('Client',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.30,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 50,
                        right: 50,
                        top: 775,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Superuser? ',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            TextButton(
                              onPressed: () {

                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero, // Remove padding
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Minimize the tap target size
                              ),
                              child: const Text(
                                'Click here',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
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
