import 'package:ap_landscaping/pages/customer/customerHome.dart';
import 'package:ap_landscaping/pages/my_home_page.dart';
import 'package:ap_landscaping/pages/provider/providerHome.dart';
import 'package:flutter/material.dart';
import 'pages/customer/customer_login/customerlogin.dart';
import 'pages/provider/provider_login/providerlogin.dart';
import 'pages/customer/customer_signup/customersignup.dart';
import 'pages/provider/provider_signup/providersignup.dart';
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
