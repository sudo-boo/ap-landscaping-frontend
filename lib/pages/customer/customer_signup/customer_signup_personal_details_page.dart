import 'package:flutter/material.dart';
import 'package:ap_landscaping/pages/customer/customer_signup/customer_signup_payment_details_page.dart';
import '../../../models/customerinfo.dart';
import '../../provider/provider_signup/providersignup.dart';

class CustomerPersonalDetailsPage extends StatefulWidget {
  final customerInfo customer_info;
  const CustomerPersonalDetailsPage({super.key, required this.customer_info});

  @override
  _CustomerPersonalDetailsPageState createState() => _CustomerPersonalDetailsPageState();
}

class _CustomerPersonalDetailsPageState extends State<CustomerPersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
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
                    widget.customer_info.address = value ?? '',
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter an address' : null,
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
                    widget.customer_info.mobile_number = value ?? '',
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a mobile number' : null,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerPaymentDetailsPage(
                                customer_info: widget.customer_info)),
                      );
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
