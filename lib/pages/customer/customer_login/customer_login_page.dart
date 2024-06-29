import 'dart:convert';
import 'package:ap_landscaping/pages/customer/customer_main.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../config.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomerSignIn extends StatefulWidget {
  const CustomerSignIn({super.key});
  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
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

  void cLogin() async {
    var cBody = {
      'email': emailController.text,
      'password': passwordController.text
    };
    var response = await http.post(Uri.parse(customerLogin),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(cBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
      var myCustomerId = jsonResponse['customerId'];
      prefs.setString('token', myToken);
      prefs.setString('profileType', 'user');
      prefs.setString('id', myCustomerId.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
            CustomerMain(token: myToken, customerId: myCustomerId
          )
        )
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // Extract the error message from response.body
          String errorMessage = "Unknown Error";
          try {
            // Parse response.body as JSON to access specific error message
            Map<String, dynamic> errorJson = jsonDecode(response.body);
            if (errorJson.containsKey("error")) {
              errorMessage = errorJson["error"];
            }
          } catch (e) {
            errorMessage = response.body;
          }

          return AlertDialog(
            title: Text("Error ${response.statusCode}"),
            content: Text(errorMessage), // Display extracted error message
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  // void customerGLogin() async {
  //   var cBody = {
  //     'role': 'customer'
  //   };
  //   final response = await http.get(
  //     Uri.parse(googleLogin),
  //     headers: {"Content-Type": "application/json"},
  //     // body: jsonEncode(cBody),
  //   );
  //   if (response.statusCode == 200) {
  //     // final Map<String, dynamic> responseData = json.decode(response.body);
  //     // final user = responseData['user'];
  //     print('worked');
  //     // You can access the user data here, such as user['id'], user['name'], etc.
  //     // return {'success': true, 'user': user};
  //   } else {
  //     // If the request fails, handle the error
  //     print('failed');
  //     // return {'success': false, 'error': 'Authentication failed'};
  //   }
  // }

  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: ['email', 'profile'],
  // );

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //
  //     if (googleUser == null) {
  //       // The user canceled the sign-in process
  //       // return;
  //       print("null googleUser");
  //     } else {
  //       print("here");
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //
  //       // Get the role, perhaps from the user's choice or app's state
  //       const String role = 'customer'; // or 'provider'
  //
  //       // Build the URL with query parameters
  //       final uri = Uri.http('localhost:8000', '/api/user/auth/google', {
  //         'role': role, // Append the role as a query parameter
  //       });
  //
  //       // Make the HTTP GET request
  //       final response = await http.get(uri);
  //
  //       // Handle the response from your server
  //       if (response.statusCode == 200) {
  //         // Successful authentication with Google
  //         // Now the server should handle the callback
  //         print("worked");
  //       } else {
  //         // Handle errors
  //         print(response.statusCode);
  //       }
  //     }
  //   } catch (error) {
  //     // Handle exceptions
  //     print(error);
  //   }
  // }

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
            child: Column(
              children: <Widget>[
              const Image(
                image: AssetImage('assets/images/login-cover.png'),
              ),
              SizedBox(height: 50,),
              const Text(
                'Welcome Back Customer!',
                style: TextStyle(
                  color: Color(0xFF3E363F),
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  // height: 0.02,
                  letterSpacing: -0.30,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter Email Address",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email Address';
                    } else if (!value.contains('@') & !value.contains('.')) {
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
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
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
                            // auth;
                            cLogin();
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          // padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50, // Adjust the height as needed
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF3E363F), // Background color
                              borderRadius: BorderRadius.circular(
                                  5), // Adjust the radius as needed
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16 *
                                    fontHelper(
                                        context), // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const customerForgotPasswordPage()));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove padding
                  tapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, // Minimize the tap target size
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
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
                      Navigator.of(context).pushReplacementNamed('/customersignup');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove padding
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimize the tap target size
                    ),
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CustomerGoogleLoginPage()
              //           )
              //       );
              //     },
              //     borderRadius: BorderRadius.circular(4.0),
              //     child: Container(
              //       height: 45,
              //       padding: EdgeInsets.all(9.0),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: Colors.grey),
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Image.asset("assets/images/google-logo.png"),
              //           SizedBox(width: 3.0),
              //           Text(
              //             'Sign in with Google',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 16.0,
              //               fontWeight: FontWeight.w600,
              //               fontFamily: 'Inter'
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              //   child: SignInWithAppleButton(
              //     onPressed: () async {
              //       final credential =
              //       await SignInWithApple.getAppleIDCredential(
              //         scopes: [
              //           AppleIDAuthorizationScopes.email,
              //           AppleIDAuthorizationScopes.fullName,
              //         ],
              //       );
              //       print(credential);
              //       // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
              //       // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              //     },
              //   ),
              // ),
            ]
            )
          )
        ),
      ),
    );
  }
}

class customerForgotPasswordPage extends StatefulWidget {
  const customerForgotPasswordPage({super.key});
  @override
  State<customerForgotPasswordPage> createState() =>
      _customerForgotPasswordPageState();
}

class _customerForgotPasswordPageState
    extends State<customerForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFBBE1C5),
          automaticallyImplyLeading: true,
          // title: Text(widget.serviceName),
          title: Text(
            'Forgot Password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
              icon: const Image(
                image: AssetImage('assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // backgroundColor: Colors.transparent,
        ),
        body: Container(
          color: const Color(0xFFBBE1C5),
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 30),
              child: Text(
                'Select contact details where you want to reset your passwrod.',
                style: TextStyle(
                  color: Color(0xFF3E363F),
                  fontSize: 16 * fontHelper(context),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.05,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        CustomPhoneNumberDialog(),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // const Image(
                        //   image: AssetImage(
                        //       'assets/images/forgotPasswordMobileNumber.png'),
                        // ),
                        const Expanded(
                          flex: 3,
                            child: Icon(Icons.message_outlined)
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            'Mobile Number',
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 20 * fontHelper(context),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.10,
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomEmailDialog(),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // const Image(
                          //   image: AssetImage(
                          //       'assets/images/forgotPasswordEmail.png'),
                          // ),
                          Expanded(
                            flex: 3,
                            child: Icon(Icons.email_outlined)
                          ),

                          Expanded(
                            flex: 7,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFF3E363F),
                                fontSize: 20 * fontHelper(context),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.10,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            )
          ]),
        ));
  }
}

class CustomPhoneNumberDialog extends StatefulWidget {
  @override
  _CustomPhoneNumberDialogState createState() =>
      _CustomPhoneNumberDialogState();
}

class _CustomPhoneNumberDialogState extends State<CustomPhoneNumberDialog> {
  late TextEditingController _mobileNumberController;
  late String resetToken;
  Future<void> forgotPasswordPhone(String phoneNumber) async {
    final Map<String, dynamic> body = {'phoneNumber': phoneNumber};

    try {
      // Make the HTTP POST request using http.post
      final response = await http.post(
        Uri.parse(customerForgotPasswordByPhone),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // Check the status code for the result
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        resetToken = responseBody['resetToken'];
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomOTPDialog(
            resetToken: resetToken,
          ),
        );
        // Handle the response data
        print(responseBody['message']);
      } else if (response.statusCode == 404) {
        // Handle the case when the customer is not found
        print('Customer not found');
      } else {
        // Handle other cases
        print('Failed to send reset token and OTP');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error generating reset token: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _mobileNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE1C5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog compact
        children: <Widget>[
          Image.asset(
            'assets/images/forgotPasswordImage.png',
            // height: 35, width: 35
          ),
          const SizedBox(height: 16.0),
          Text(
            "Enter your mobile number",
            style: TextStyle(
              color: Color(0xFF3E363F),
              fontSize: 24 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.19,
            ),
          ),
          const SizedBox(height: 24.0),
          TextField(
            controller: _mobileNumberController,
            decoration: InputDecoration(
              hintText: 'Mobile Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                // Implement the reset password logic here
                forgotPasswordPhone(_mobileNumberController.text);
                // Navigator.of(context).pop(); // To close the dialog
              },
              child: const Text("Proceed"),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEmailDialog extends StatefulWidget {
  @override
  _CustomEmailDialogState createState() => _CustomEmailDialogState();
}

class _CustomEmailDialogState extends State<CustomEmailDialog> {
  late TextEditingController _emailController;
  late String resetToken;
  Future<void> forgotPasswordEmail(String email) async {
    final Map<String, dynamic> body = {'email': email};

    try {
      // Make the HTTP POST request using http.post
      final response = await http.post(
        Uri.parse(customerForgotPasswordByEmail),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // Check the status code for the result
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        resetToken = responseBody['resetToken'];
        // Handle the response data
        print(responseBody['message']);
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomOTPDialog(
            resetToken: resetToken,
          ),
        );
      } else if (response.statusCode == 404) {
        // Handle the case when the customer is not found
        print('Customer not found');
      } else {
        // Handle other cases
        print('Failed to send reset token and OTP');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error generating reset token: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE1C5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog compact
        children: <Widget>[
          Image.asset(
            'assets/images/forgotPasswordImage.png',
            // height: 35, width: 35
          ),
          const SizedBox(height: 16.0),
          Text(
            "Enter your Email Address",
            style: TextStyle(
              color: Color(0xFF3E363F),
              fontSize: 24 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.19,
            ),
          ),
          const SizedBox(height: 24.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                forgotPasswordEmail(_emailController.text);
                // Implement the reset password logic here
                // Navigator.of(context).pop(); // To close the dialog
              },
              child: const Text("Proceed"),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOTPDialog extends StatefulWidget {
  final String resetToken;

  const CustomOTPDialog({super.key, required this.resetToken});
  @override
  _CustomOTPDialogState createState() => _CustomOTPDialogState();
}

class _CustomOTPDialogState extends State<CustomOTPDialog> {
  late TextEditingController _otpTextController;
  bool obscureText1 = false;
  bool obscureText2 = false;

  @override
  void initState() {
    super.initState();
    _otpTextController = TextEditingController();
  }

  @override
  void dispose() {
    _otpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE1C5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog compact
        children: <Widget>[
          Image.asset(
            'assets/images/forgotPasswordImage.png',
            // height: 35, width: 35
          ),
          const SizedBox(height: 16.0),
          Text(
            "OTP sent",
            style: TextStyle(
              color: Color(0xFF3E363F),
              fontSize: 24 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.19,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Type the OTP sent to your selected contact details.',
            style: TextStyle(
              color: Color(0xFF3E363F),
              fontSize: 18 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.07,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _otpTextController,
            obscureText: !obscureText2,
            decoration: InputDecoration(
              hintText: 'Type OTP',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText2 ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText2 = !obscureText2;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                // Implement the reset password logic here
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomPasswordResetDialog(
                    otp: int.parse(_otpTextController.text),
                    resetToken: widget.resetToken,
                  ),
                );
              },
              child: const Text("Proceed"),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPasswordResetDialog extends StatefulWidget {
  @override
  final otp;
  final String resetToken;
  const CustomPasswordResetDialog(
      {required this.otp, Key? key, required this.resetToken})
      : super(key: key);
  _CustomPasswordResetDialogState createState() =>
      _CustomPasswordResetDialogState();
}

class _CustomPasswordResetDialogState extends State<CustomPasswordResetDialog> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  late String resetToken;
  bool obscureText1 = false;
  bool obscureText2 = false;

  Future<void> resetPassword(
    int otp,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(customerResetPassword),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${widget.resetToken}', // Add the reset token to the Authorization header
        },
        body: json.encode({
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        print(
            'Password reset successfully. Message: ${json.decode(response.body)['message']}');
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Password Reset Successful"),
                // content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacementNamed('/customersignin');
                    },
                  )
                ],
              );
            });
      } else if (response.statusCode == 401) {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception(
            'Failed to reset password: ${json.decode(response.body)['error']}');
      } else {
        throw Exception(
            'Failed to reset password with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any kind of exception occurs, it's likely because there was an error connecting
      // to the server, or the server returned an unexpected response.
      print('Error resetting password: $e');
      throw e; // You might not want to re-throw the exception, depending on your error handling needs.
    }
  }

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE1C5),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog compact
        children: <Widget>[
          Image.asset(
            'assets/images/forgotPasswordImage.png',
            // height: 35, width: 35
          ),
          const SizedBox(height: 16.0),
          Text(
            "Reset Your Password",
            style: TextStyle(
              color: Color(0xFF3E363F),
              fontSize: 24 * fontHelper(context),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.19,
            ),
          ),
          const SizedBox(height: 24.0),
          TextField(
            controller: _newPasswordController,
            obscureText: !obscureText1,
            decoration: InputDecoration(
              hintText: 'New Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText1 ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText1 = !obscureText1;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _confirmPasswordController,
            obscureText: !obscureText2,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText2 ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText2 = !obscureText2;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                if (_confirmPasswordController.text ==
                    _newPasswordController.text) {
                  resetPassword(widget.otp, _newPasswordController.text);
                }
              },
              child: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
