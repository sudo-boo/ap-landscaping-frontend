import 'package:ap_landscaping/pages/provider/provider_signup/provider_payment_details.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/providerinfo.dart';

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
