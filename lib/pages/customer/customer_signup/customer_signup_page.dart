import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/customerinfo.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import '../../../config.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({super.key});
  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  final _formKey = GlobalKey<FormState>();
  customerInfo customer_info = customerInfo();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured1 = true;
  bool _isObscured2 = true;

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigit = false;
  bool hasSpecialCharacter = false;
  bool hasMinLength = false;

  void cSignup(customerInfo customer_info) async {
    var regBody = {
      "username": customer_info.username,
      "email": customer_info.email,
      "mobilenumber": customer_info.mobile_number,
      "address": customer_info.address,
      "carddetails": customer_info.card_details,
      "cvv": customer_info.cvv,
      "paypalid": customer_info.paypal_id,
      "aectransfer": customer_info.aec_transfer,
      "cardtype": customer_info.card_type,
      "cardholdersname": customer_info.card_holders_name,
      "cardnumber": customer_info.card_number,
      "password": customer_info.password,
    };

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            width: 50.0, // Example width
            height: 50.0, // Example height
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    var response = await http.post(Uri.parse(customerRegister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    Navigator.of(context).pop();

    if (response.statusCode == 201) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                SizedBox(height: 20),
                Text(
                    'Congratulations you have been successfully registered!!\nYou can now Log In with your credentials',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/customersignin',
                          (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Go to Login Page',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
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


  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordCriteria(String password) {
    setState(() {
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasDigit = password.contains(RegExp(r'[0-9]'));
      hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      hasMinLength = password.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: const Text('AP Landscaping'),
        // centerTitle: true,
        backgroundColor: const Color(0xFFBBE1C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/customersignin'),
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
                  image: AssetImage('assets/images/signupPage1.png'),
                ),
                SizedBox(height: 20,),
                Text(
                  'Hello There!',
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: fontHelper(context) * 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth(context) * 0.03),
                      const Text(
                        "User Credentials",
                        style: TextStyle(fontFamily: 'Inter', height: 0),
                      ),
                      SizedBox(width: screenWidth(context) * 0.03),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => customer_info.username = value ?? '',
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a username' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email address', // Uncommented and added a border
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => customer_info.email = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      // Regex for basic email validation
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscured1,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured1 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured1 = !_isObscured1;
                          });
                        },
                      ),
                    ),
                    onChanged: _checkPasswordCriteria,
                    onSaved: (value) => customer_info.password = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Column(
                    children: [
                      _buildPasswordCriteria("At least 8 characters", hasMinLength),
                      _buildPasswordCriteria("Contains uppercase letter", hasUppercase),
                      _buildPasswordCriteria("Contains lowercase letter", hasLowercase),
                      _buildPasswordCriteria("Contains digit", hasDigit),
                      _buildPasswordCriteria("Contains special character", hasSpecialCharacter),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                  child: TextFormField(
                    obscureText: _isObscured2,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured2 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured2 = !_isObscured2;
                          });
                        },
                      ),
                    ),
                    validator: (value) => value != _passwordController.text ? 'Password does not match' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth(context) * 0.03),
                      const Text(
                        "Contact Details",
                        style: TextStyle(fontFamily: 'Inter', height: 0),
                      ),
                      SizedBox(width: screenWidth(context) * 0.03),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    maxLength: 80, // Maximum length of the input
                    maxLines: null, // Allows multiline input
                    onSaved: (value) => customer_info.address = value ?? '',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an address';
                      }
                      if (value.length < 8 || value.length > 60) {
                        return 'Address must be between 8 and 60 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 50),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mobile number',
                      prefixText: '+1 ',
                      prefixStyle: TextStyle(color: Colors.black), // Customize prefix text style if needed
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10), // Limit total input length including prefix
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    onSaved: (value) {
                      // Remove any non-digit characters before saving
                      customer_info.mobile_number = value!.replaceAll(RegExp(r'[^\d]'), '');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      // Regular expression to match a typical 10-digit mobile number
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),

                InkWell(
                  // onTap: () {
                  //   if (_formKey.currentState!.validate()) {
                  //     _formKey.currentState!.save();
                  //     cSignup(customer_info);
                  //   }
                  // },

                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (!hasMinLength || !hasUppercase || !hasLowercase || !hasDigit || !hasSpecialCharacter) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password must meet all criteria.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        print(customer_info.mobile_number);
                        _formKey.currentState!.save();
                        cSignup(customer_info);
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E363F), // Background color
                        borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight(context) * 0.1)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordCriteria(String criteria, bool conditionMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Row(
        children: [
          Icon(
            conditionMet ? Icons.check_circle : Icons.cancel_rounded,
            color: conditionMet ? Colors.green : Colors.redAccent,
            size: 15,
          ),
          const SizedBox(width: 10),
          Text(
              criteria,
            style: const TextStyle(
              fontFamily: 'Inter',
              height: 0,
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
