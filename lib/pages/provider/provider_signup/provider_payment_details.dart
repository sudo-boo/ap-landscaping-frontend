// import 'dart:convert';
// import '../../../config.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../models/providerinfo.dart';
//
//
// class PaymentDetailsPage extends StatefulWidget {
//   final providerInfo provider_info;
//   const PaymentDetailsPage({super.key, required this.provider_info});
//
//   @override
//   _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
// }
//
// class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscured3 = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: const Color(0xFFBBE1C5),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         color: const Color(0xFFBBE1C5),
//         height: double.infinity,
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 const Image(
//                   image: AssetImage('assets/images/signupPage3.png'),
//                 ),
//                 const Text(
//                   'Bonjour!!',
//                   style: TextStyle(
//                     color: Color(0xFF3E363F),
//                     fontSize: 50,
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w600,
//                     height: 0.02,
//                     letterSpacing: -0.30,
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       labelText: 'Name of the Bank',
//                 //       // enabledBorder: OutlineInputBorder(
//                 //       //   borderRadius: BorderRadius.circular(10.0),
//                 //       // ),
//                 //     ),
//                 //     onSaved: (value) =>
//                 //         widget.provider_info.bank_name = value ?? '',
//                 //     validator: (value) =>
//                 //         value!.isEmpty ? 'Please enter the bank name' : null,
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       labelText: 'Account number',
//                 //       // enabledBorder: OutlineInputBorder(
//                 //       //   borderRadius: BorderRadius.circular(10.0),
//                 //       // ),
//                 //     ),
//                 //     onSaved: (value) =>
//                 //         widget.provider_info.account_nummber = value ?? '',
//                 //     validator: (value) => value!.isEmpty
//                 //         ? 'Please enter your Account number'
//                 //         : null,
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       labelText: 'Card Details',
//                 //       // enabledBorder: OutlineInputBorder(
//                 //       //   borderRadius: BorderRadius.circular(10.0),
//                 //       // ),
//                 //     ),
//                 //     onSaved: (value) =>
//                 //         widget.provider_info.card_details = value ?? '',
//                 //     validator: (value) =>
//                 //         value!.isEmpty ? 'Please enter the card details' : null,
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       labelText: 'AEC Transfer',
//                 //       // enabledBorder: OutlineInputBorder(
//                 //       //   borderRadius: BorderRadius.circular(10.0),
//                 //       // ),
//                 //     ),
//                 //     onSaved: (value) =>
//                 //         widget.provider_info.aec_transfer = value ?? '',
//                 //     validator: (value) => value!.isEmpty ? 'AEC Transfer' : null,
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
//                 //   child: TextFormField(
//                 //     decoration: const InputDecoration(
//                 //       labelText: 'Type of card',
//                 //       // enabledBorder: OutlineInputBorder(
//                 //       //   borderRadius: BorderRadius.circular(10.0),
//                 //       // ),
//                 //     ),
//                 //     onSaved: (value) =>
//                 //         widget.provider_info.card_type = value ?? '',
//                 //     validator: (value) =>
//                 //         value!.isEmpty ? 'Please enter your card type' : null,
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Card Number',
//                       // enabledBorder: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(10.0),
//                       // ),
//                     ),
//                     onSaved: (value) =>
//                     widget.provider_info.card_number = value ?? '',
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the card number' : null,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Card Holder Name',
//                       // enabledBorder: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(10.0),
//                       // ),
//                     ),
//                     onSaved: (value) =>
//                     widget.provider_info.card_holders_name = value ?? '',
//                     validator: (value) => value!.isEmpty
//                         ? 'Please enter the card holder name'
//                         : null,
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
//                   child: TextFormField(
//                     obscureText: _isObscured3,
//                     decoration: InputDecoration(
//                       labelText: 'CVV',
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isObscured3
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isObscured3 = !_isObscured3;
//                           });
//                         },
//                       ),
//                       // enabledBorder: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(10.0),
//                       // ),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onSaved: (value) => widget.provider_info.cvv = value ?? '',
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter cvv' : null,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Paypal ID',
//                       // enabledBorder: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(10.0),
//                       // ),
//                     ),
//                     onSaved: (value) =>
//                     widget.provider_info.paypal_id = value ?? '',
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter your Paypal ID' : null,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // save the details
//                       // pSignup(widget.provider_info);
//                     }
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 50, // Adjust the height as needed
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF3E363F), // Background color
//                         borderRadius: BorderRadius.circular(
//                             5), // Adjust the radius as needed
//                       ),
//                       child: const Text(
//                         'Register',
//                         style: TextStyle(
//                           color: Colors.white, // Text color
//                           fontSize: 16, // Adjust the font size as needed
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }