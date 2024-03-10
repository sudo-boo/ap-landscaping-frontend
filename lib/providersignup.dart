import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:multiselect/multiselect.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

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
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
                  image: AssetImage('lib/assets/images/signupPage1.png'),
                ),
                const Text(
                  'Hello There!',
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: 50,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.02,
                    letterSpacing: -0.30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.username = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.email = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an email' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.password = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
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
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    validator: (value) => value != _passwordController.text
                        ? 'Password does not match'
                        : null,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QualificationsPage(
                                provider_info: provider_info)),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity, // Takes the width of the parent
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E363F), // Background color
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QualificationsPage extends StatefulWidget {
  final providerInfo provider_info;
  QualificationsPage({super.key, required this.provider_info});
  @override
  _QualificationsPageState createState() => _QualificationsPageState();
}

class _QualificationsPageState extends State<QualificationsPage> {
  final _formKey = GlobalKey<FormState>();
  // List<String> Services = ['Apple', 'Banana', 'Grapes', 'Orange', 'Mango'];
  // Modify this list with the actual list of services
  List<String> selectedServices = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFBBE1C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
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
                  image: AssetImage('lib/assets/images/signupPage2.png'),
                ),
                const Text(
                  'Hola!!',
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: 50,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.02,
                    letterSpacing: -0.30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.address = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an address' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Years of Service',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => widget.provider_info
                        .years_of_experience = int.tryParse(value ?? '0') ?? 0,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your years of experience'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.qualifications = value ?? '',
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your Qualifications'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mobile number',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.mobile_number = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a mobile number' : null,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Bio',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) => widget.provider_info.bio = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Let customers know you' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       // border: Border.all(color: Colors.black), // Border color
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: DropDownMultiSelect(
                //       options: Services,
                //       selectedValues: selectedServices,
                //       onChanged: (value) {
                //         setState(() {
                //           selectedServices = value;
                //           widget.provider_info.services = value;
                //         });
                //       },
                //       whenEmpty: 'Select the services you can provide.',
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetailsPage(
                                provider_info: widget.provider_info)),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity, // Takes the width of the parent
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E363F), // Background color
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentDetailsPage extends StatefulWidget {
  final providerInfo provider_info;
  const PaymentDetailsPage({super.key, required this.provider_info});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured3 = true;
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
    };
    var response = await http.post(Uri.parse(providerRegister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    // var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratsPage()),
      );
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
          onPressed: () => Navigator.pop(context),
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
                  image: AssetImage('lib/assets/images/signupPage3.png'),
                ),
                const Text(
                  'Bonjour!!',
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: 50,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.02,
                    letterSpacing: -0.30,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Name of the Bank',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.provider_info.bank_name = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Please enter the bank name' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Account number',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.provider_info.account_nummber = value ?? '',
                //     validator: (value) => value!.isEmpty
                //         ? 'Please enter your Account number'
                //         : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Card Details',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.provider_info.card_details = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Please enter the card details' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'AEC Transfer',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.provider_info.aec_transfer = value ?? '',
                //     validator: (value) => value!.isEmpty ? 'AEC Transfer' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Type of card',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.provider_info.card_type = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Please enter your card type' : null,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.card_number = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter the card number' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Holder Name',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.card_holders_name = value ?? '',
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the card holder name'
                        : null,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    obscureText: _isObscured3,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured3
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured3 = !_isObscured3;
                          });
                        },
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => widget.provider_info.cvv =
                        int.tryParse(value ?? '0') ?? 0,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter cvv' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Paypal ID',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) =>
                        widget.provider_info.paypal_id = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your Paypal ID' : null,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // save the details
                      pSignup(widget.provider_info);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E363F), // Background color
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});
  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('AP Landscaping'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 250),
          const Text(
              'Congratulations you have been successfully registered!!\nPlease verify your email before logging in\nTo do so an email is sent to you,Click the verify button on it.'),
          const SizedBox(height: 75),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/providersignin');
            },
            child:
                const Text('Go to Login Page', style: TextStyle(fontSize: 18)),
          )
        ]),
      ),
    );
  }
}
