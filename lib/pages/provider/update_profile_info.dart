import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../models/providerinfo.dart';
import 'dart:convert';


class updateprofileInfoPage extends StatefulWidget {
  final token;
  final providerId;
  const updateprofileInfoPage(
      {required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<updateprofileInfoPage> createState() => _updateprofileInfoPageState();
}

class _updateprofileInfoPageState extends State<updateprofileInfoPage> {
  providerInfo provider_info = providerInfo();
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileNumberController = TextEditingController(text: '');
    fetchProviderInfo().then((fetchedProviderInfo) {
      _usernameController.text = fetchedProviderInfo.username ?? '';
      _emailController.text = fetchedProviderInfo.email ?? '';
      _addressController.text = fetchedProviderInfo.address ?? '';
      _mobileNumberController.text = fetchedProviderInfo.mobile_number ?? '';
      setState(() {
        provider_info = fetchedProviderInfo;
        isLoading = false;
      });
    });
  }

  Future<providerInfo> fetchProviderInfo() async {
    providerInfo provider_info1 = providerInfo();
    final url = Uri.parse(providerProfileInfo); // Replace with your API URL
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          provider_info1.username = data['provider']['username'] ?? '';
          provider_info1.email = data['provider']['email'] ?? '';
          provider_info1.mobile_number = data['provider']['mobilenumber'] ?? '';
          provider_info1.password = data['provider']['password'] ?? '';
          provider_info1.address = data['provider']['address'] ?? '';
          provider_info1.card_details = data['provider']['carddetails'] ?? '';
          provider_info1.cvv = data['provider']['cvv'] ?? '';
          provider_info1.paypal_id = data['provider']['paypalid'] ?? '';
          provider_info1.aec_transfer = data['provider']['aectransfer'] ?? '';
          provider_info1.card_type = data['provider']['cardtype'] ?? '';
          provider_info1.card_holders_name =
              data['provider']['cardholdersname'] ?? '';
          provider_info1.card_number = data['provider']['cardnumber'] ?? '';
          isLoading = false;
        });
        return provider_info1;
      } else {
        // Handle error or non-200 responses
        print('Failed to fetch provider info');
        return provider_info1;
      }
    } catch (e) {
      print('Error: $e');
      return provider_info1;
    }
  }

  Future<void> updateProviderInfo() async {
    final url = Uri.parse(providerProfileInfo);
    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode({
            'username': provider_info.username,
            'email': provider_info.email,
            'mobilenumber': provider_info.mobile_number,
            'address': provider_info.address,
            'carddetails': provider_info.card_details,
            'cvv': provider_info.cvv,
            'paypalid': provider_info.paypal_id,
            'aectransfer': provider_info.aec_transfer,
            'cardtype': provider_info.card_type,
            'cardholdersname': provider_info.card_holders_name,
            'cardnumber': provider_info.card_number,
          }));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          provider_info.username = data['updatedProvider']['username'] ?? '';
          provider_info.email = data['updatedProvider']['email'] ?? '';
          provider_info.mobile_number =
              data['updatedProvider']['mobilenumber'] ?? '';
          provider_info.address = data['updatedProvider']['address'] ?? '';
          provider_info.card_details =
              data['updatedProvider']['carddetails'] ?? '';
          provider_info.cvv = data['updatedProvider']['cvv'] ?? '';
          provider_info.paypal_id = data['updatedProvider']['paypalid'] ?? '';
          provider_info.aec_transfer =
              data['updatedProvider']['aectransfer'] ?? '';
          provider_info.card_type = data['updatedProvider']['cardtype'] ?? '';
          provider_info.card_number =
              data['updatedProvider']['cardnumber'] ?? '';
        });
        print('Provider profile updated successfully');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Profile Successfully Updated"),
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
      } else {
        print('Failed to update provider profile');
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
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'My Account',
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
                image: AssetImage('lib/assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                    child: TextFormField(
                      controller: _mobileNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          provider_info.username = _usernameController.text;
                          provider_info.email = _emailController.text;
                          provider_info.address = _addressController.text;
                          provider_info.mobile_number =
                              _mobileNumberController.text;
                        });
                        updateProviderInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        // backgroundColor: Colors.blue,
                        backgroundColor: const Color(0xFFA686FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ), // Calling the update function
                      child: const Text('Update Profile'),
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
}
