import 'package:ap_landscaping/pages/SuperUser/superuser_main.dart';
import 'package:ap_landscaping/pages/customer/customer_main.dart';
import 'package:ap_landscaping/pages/provider/privider_main.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/SuperUser/SuperUserLogin/superuser_login_page.dart';
import 'package:ap_landscaping/pages/my_home_page.dart';
import 'package:flutter/services.dart';
import 'pages/customer/customer_login/customer_login_page.dart';
import 'pages/provider/provider_login/provider_login_page.dart';
import 'pages/customer/customer_signup/customer_signup_page.dart';
import 'pages/provider/provider_signup/provider_signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
    profileType: prefs.getString('profileType'),
    id: prefs.getString('id'),
  ));
}

class MyApp extends StatelessWidget {
  final profileType;
  final token;
  final id;
  const MyApp(
      {@required this.token,
      Key? key,
      required this.profileType,
      required this.id})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Widget homeWidget;
    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired) {
        homeWidget = const MyHomePage(title: 'AP Landscaping');
      } else {
        if (profileType == 'user') {
          homeWidget = CustomerMain(token: token, customerId: id);
        } else if (profileType == 'provider') {
          homeWidget = ProviderMain(token: token, providerId: id);
        } else if(profileType == 'superuser'){
          homeWidget = SuperUserMain(token: token, superuserId: id);
        } else{
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
        '/superusersignin': (BuildContext ctx) => const SuperUserSignIn(),
        '/customersignup': (BuildContext ctx) => const CustomerSignUp(),
        '/providersignup': (BuildContext ctx) => const ProviderSignUp(),
        // '/superusersignup': (BuildContext ctx) => const SuperUserSignUp(),
      },
      home: homeWidget,
    );
  }
}
