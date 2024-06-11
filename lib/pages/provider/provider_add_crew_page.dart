import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/crewinfo.dart';

class ProviderAddCrewPage extends StatefulWidget {
  final token;
  final providerId;

  const ProviderAddCrewPage({super.key, this.token, this.providerId});
  @override
  State<ProviderAddCrewPage> createState() => _ProviderAddCrewPageState();
}

class _ProviderAddCrewPageState extends State<ProviderAddCrewPage> {
  crewInfo crew_info = crewInfo();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> createCrew() async {
    var data = {
      "username": crew_info.username,
      "email": crew_info.email,
      "mobilenumber": crew_info.mobilenumber,
      "address": crew_info.city,
      "qualifications": crew_info.expertise,
      "yearsofexperience": crew_info.fullname,
    };
    try {
      final response = await http.post(
        Uri.parse(crewCreate),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response: $responseData');
      } else {
        print('Error: ${response.statusCode}');
        print('Error Body: ${response.body}');
      }
    } catch (error) {
      print('Error creating crew: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Crew',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
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
        // backgroundColor: Colors.green[900],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.fullname = value ?? '',
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your full name' : null,
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'User Name',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.username = value ?? '',
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your username' : null,
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.email = value ?? '',
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your email address'
                                  : null,
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.mobilenumber = value ?? '',
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your phone number'
                                  : null,
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'City',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.city = value ?? '',
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your city' : null,
                            ),
                          ),
                        ),
                        Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Expertise',
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => crew_info.expertise = value ?? '',
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your expertise' : null,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!
                                    .save(); // This triggers the onSaved callback for each TextFormField
                                createCrew();
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: 327,
                              height: 56,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFA686FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add Crew',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.07,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
