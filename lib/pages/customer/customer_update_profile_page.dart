import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/customerinfo.dart';


class CustomerUpdateProfileInfoPage extends StatefulWidget {
  final token;
  final customerId;
  const CustomerUpdateProfileInfoPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  State<CustomerUpdateProfileInfoPage> createState() => _CustomerUpdateProfileInfoPageState();
}

class _CustomerUpdateProfileInfoPageState extends State<CustomerUpdateProfileInfoPage> {
  customerInfo customer_info = customerInfo();
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
    fetchCustomerInfo().then((fetchedCustomerInfo) {
      _usernameController.text = fetchedCustomerInfo.username ?? '';
      _emailController.text = fetchedCustomerInfo.email ?? '';
      _addressController.text = fetchedCustomerInfo.address ?? '';
      _mobileNumberController.text = fetchedCustomerInfo.mobile_number ?? '';
      setState(() {
        customer_info = fetchedCustomerInfo;
        isLoading = false;
      });
    });
  }

  Future<customerInfo> fetchCustomerInfo() async {
    customerInfo customer_info1 = customerInfo();
    final url = Uri.parse(customerProfileInfo); // Replace with your API URL
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
          customer_info1.username = data['customer']['username'] ?? '';
          customer_info1.email = data['customer']['email'] ?? '';
          customer_info1.mobile_number = data['customer']['mobilenumber'] ?? '';
          customer_info1.password = data['customer']['password'] ?? '';
          customer_info1.address = data['customer']['address'] ?? '';
          customer_info1.card_details = data['customer']['carddetails'] ?? '';
          customer_info1.cvv = data['customer']['cvv'] ?? '';
          customer_info1.paypal_id = data['customer']['paypalid'] ?? '';
          customer_info1.aec_transfer = data['customer']['aectransfer'] ?? '';
          customer_info1.card_type = data['customer']['cardtype'] ?? '';
          customer_info1.card_holders_name =
              data['customer']['cardholdersname'] ?? '';
          customer_info1.card_number = data['customer']['cardnumber'] ?? '';
          isLoading = false;
        });
        return customer_info1;
      } else {
        // Handle error or non-200 responses
        print('Failed to fetch customer info');
        return customer_info1;
      }
    } catch (e) {
      print('Error: $e');
      return customer_info1;
    }
  }

  Future<void> updateCustomerInfo() async {
    final url = Uri.parse(customerProfileInfo);
    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode({
            'username': customer_info.username,
            'email': customer_info.email,
            'mobilenumber': customer_info.mobile_number,
            'address': customer_info.address,
            'carddetails': customer_info.card_details,
            'cvv': customer_info.cvv,
            'paypalid': customer_info.paypal_id,
            'aectransfer': customer_info.aec_transfer,
            'cardtype': customer_info.card_type,
            'cardholdersname': customer_info.card_holders_name,
            'cardnumber': customer_info.card_number,
          }));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          customer_info.username = data['updatedCustomer']['username'] ?? '';
          customer_info.email = data['updatedCustomer']['email'] ?? '';
          customer_info.mobile_number =
              data['updatedCustomer']['mobilenumber'] ?? '';
          customer_info.address = data['updatedCustomer']['address'] ?? '';
          customer_info.card_details =
              data['updatedCustomer']['carddetails'] ?? '';
          customer_info.cvv = data['updatedCustomer']['cvv'] ?? '';
          customer_info.paypal_id = data['updatedCustomer']['paypalid'] ?? '';
          customer_info.aec_transfer =
              data['updatedCustomer']['aectransfer'] ?? '';
          customer_info.card_type = data['updatedCustomer']['cardtype'] ?? '';
          customer_info.card_number =
              data['updatedCustomer']['cardnumber'] ?? '';
        });
        print('Customer profile updated successfully');
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
        print('Failed to update customer profile');
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
              fontSize: 20,
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
                      //     widget.customer_info.address = value ?? '',
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
                      //     widget.customer_info.address = value ?? '',
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
                      //     widget.customer_info.address = value ?? '',
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
                      //     widget.customer_info.address = value ?? '',
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
                          customer_info.username = _usernameController.text;
                          customer_info.email = _emailController.text;
                          customer_info.address = _addressController.text;
                          customer_info.mobile_number =
                              _mobileNumberController.text;
                        });
                        updateCustomerInfo();
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
