import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/pages/customer/congrats_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/config.dart';
import '/models/customerinfo.dart';

class PaymentDetailsPage extends StatefulWidget {
  final customerInfo customer_info;
  const PaymentDetailsPage({super.key, required this.customer_info});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured3 = true;
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
    var response = await http.post(Uri.parse(customerRegister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
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
                //       padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //       child:
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Name of the Bank',
                //                         enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),),
                //   onSaved: (value) =>
                //       widget.customer_info.bank_name = value ?? '',
                //   validator: (value) =>
                //       value!.isEmpty ? 'Please enter the bank name' : null,
                // ),),
                // Padding(
                //       padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //       child:
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Account number',
                //                         enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),),
                //   onSaved: (value) =>
                //       widget.customer_info.account_nummber = value ?? '',
                //   validator: (value) =>
                //       value!.isEmpty ? 'Please enter your Account number' : null,
                // ),),
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
                    widget.customer_info.card_number = value ?? '',
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
                    widget.customer_info.card_holders_name = value ?? '',
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
                          _isObscured3 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured3 = !_isObscured3;
                          });
                        },
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                      ),),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => widget.customer_info.cvv =
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
                    widget.customer_info.paypal_id = value ?? '',
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter your Paypal ID' : null,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Card Details',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.customer_info.card_details = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Please enter the card details' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'AEC Transfer',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.customer_info.aec_transfer = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'AEC Transfer' : null,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       labelText: 'Type of card',
                //       // enabledBorder: OutlineInputBorder(
                //       //   borderRadius: BorderRadius.circular(10.0),
                //       // ),
                //     ),
                //     onSaved: (value) =>
                //         widget.customer_info.card_type = value ?? '',
                //     validator: (value) =>
                //         value!.isEmpty ? 'Please enter your card type' : null,
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // save the details
                      cSignup(widget.customer_info);
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
