import 'dart:convert';
import 'package:ap_landscaping/pages/SuperUser/superuser_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config.dart';

class SuperUserSignIn extends StatefulWidget {
  const SuperUserSignIn({super.key});
  @override
  State<SuperUserSignIn> createState() => _SuperUserSignInState();
}

class _SuperUserSignInState extends State<SuperUserSignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  late SharedPreferences prefs;
  bool _isObscured = true;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void sLogin() async {
    var pBody = {
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await http.post(Uri.parse(superUserLogin),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(pBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
      var mySuperUserId = jsonResponse['superuserId'];
      prefs.setString('token', myToken);
      prefs.setString('profileType', 'superuser');
      prefs.setString('id', mySuperUserId.toString());
      // print(myProviderId);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SuperUserPage(token: myToken, superuserId: mySuperUserId)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              // content: Text(err.message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFBBE1C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
        ),
      ),
      body: Container(
        color: const Color(0xFFBBE1C5),
        height: double.infinity,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  const Image(
                    image: AssetImage('lib/assets/images/loginPage.png'),
                  ),
                  const Text(
                    'Welcome Back SuperUser!',
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      // height: 0.02,
                      letterSpacing: -0.30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Enter Email Address",
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                    child: TextFormField(
                      obscureText: _isObscured,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        // else if (value.length < 6) {
                        //   return 'Password must be atleast 6 characters!';
                        // }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          //auth
                          sLogin();
                        }
                      },
                      child: SizedBox(
                        width: double.infinity, // Takes the width of the parent
                        // padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50, // Adjust the height as needed
                          decoration: BoxDecoration(
                            color: const Color(0xFF3E363F), // Background color
                            borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .pushReplacementNamed('/superusersignup');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove padding
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Minimize the tap target size
                        ),
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )]
                )
            )
        ),
      ),
    );
  }
}