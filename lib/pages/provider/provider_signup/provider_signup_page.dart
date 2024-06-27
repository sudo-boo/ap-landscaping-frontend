import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import '../../../config.dart';
import '../../../utilities/helper_functions.dart';
import '../../services_data.dart';

class ProviderSignUp extends StatefulWidget {
  const ProviderSignUp({super.key});
  @override
  State<ProviderSignUp> createState() => _ProviderSignUpState();
}

class _ProviderSignUpState extends State<ProviderSignUp> {
  final _formKey = GlobalKey<FormState>();
  providerInfo provider_info = providerInfo();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured1 = true;
  bool _isObscured2 = true;

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigit = false;
  bool hasSpecialCharacter = false;
  bool hasMinLength = false;

  List<String> services = servicesData.map((service) => service.keys.first).toList();
  Map<String, bool> selectedServices = {};

  void pSignup(providerInfo provider_info) async {
    var regBody = {
      "username": provider_info.username,
      "email": provider_info.email,
      "mobilenumber": provider_info.mobile_number,
      "address": provider_info.address,
      "carddetails": provider_info.card_details,
      "cvv": provider_info.cvv,
      "paypalid": provider_info.paypal_id,
      "aectransfer": provider_info.aec_transfer,
      "cardtype": provider_info.card_type,
      "cardholdersname": provider_info.card_holders_name,
      "cardnumber": provider_info.card_number,
      "password": provider_info.password,
      "services": provider_info.services
    };

    // Loading PopUp

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

    var response = await http.post(Uri.parse(providerRegister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    Navigator.of(context).pop();

    // var jsonResponse = jsonDecode(response.body);
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
                      '/providersignin',
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Go to Login Page',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ), backgroundColor: Colors.green,
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
  void initState() {
    super.initState();
    for (var service in services) {
      selectedServices[service] = false;
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
        backgroundColor: const Color(0xFFBBE1C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/providersignin'),
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
                    height: 0.02,
                    letterSpacing: -0.30,
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
                    ),
                    onSaved: (value) => provider_info.username = value ?? '',
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
                    onSaved: (value) => provider_info.email = value ?? '',
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
                    onSaved: (value) => provider_info.password = value ?? '',
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                        "Services",
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
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Column(
                    children: services.map((service) {
                      return CheckboxListTile(
                        title: Text(
                          service,
                          style: const TextStyle(fontFamily: 'Inter', height: 0, fontSize: 14),
                        ),
                        value: selectedServices[service],
                        dense: true,  // Makes the tile dense
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),  // Adjusts the padding
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4), // Adjusts the visual density
                        onChanged: (bool? value) {
                          setState(() {
                            selectedServices[service] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Years of Service',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => provider_info.years_of_experience = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter your years of experience' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                    ),
                    onSaved: (value) => provider_info.qualifications = value ?? '',
                    validator: (value) => value!.isEmpty ? 'Please enter your Qualifications' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
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
                    ),
                    maxLength: 80, // Maximum length of the input
                    maxLines: null, // Allows multiline input
                    onSaved: (value) => provider_info.address = value ?? '',
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
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10), // Limit total input length including prefix
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    onSaved: (value) {
                      // Remove any non-digit characters before saving
                      provider_info.mobile_number = value!.replaceAll(RegExp(r'[^\d]'), '');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {return 'Please enter a mobile number';}
                      // Regular expression to match a typical 10-digit mobile number
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {return 'Please enter a valid mobile number';}
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (!hasMinLength || !hasUppercase || !hasLowercase || !hasDigit || !hasSpecialCharacter) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password must meet all criteria.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (selectedServices.values.every((value) => !value)) {
                        // Check if no service is selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least one service.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        _formKey.currentState!.save();
                        provider_info.services = selectedServices.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList();
                        pSignup(provider_info);
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity, // Takes the width of the parent
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
