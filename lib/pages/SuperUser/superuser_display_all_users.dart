import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/customerinfo.dart';
import '../../config.dart';

class SuperUserAllcustomersPage extends StatefulWidget {
  @override
  _SuperUserAllcustomersPageState createState() => _SuperUserAllcustomersPageState();
}

class _SuperUserAllcustomersPageState extends State<SuperUserAllcustomersPage> {
  late Future<List<customerInfo>> _customerDetailsFuture;

  @override
  void initState() {
    super.initState();
    _customerDetailsFuture = fetchAllcustomerDetails();
  }


  Future<List<customerInfo>> fetchAllcustomerDetails() async {
    try {
      print('Fetching customer details...');
      final response = await http.get(
        Uri.parse(superUserGetAllUsers),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> customersData = data['customers'];

        List<customerInfo> allcustomersList = [];

        for (var customerData in customersData) {
          // print("$customerData");
          customerInfo customer = customerInfo(
            username: customerData['username'].toString(),
            email: customerData['email'].toString(),
            mobile_number: customerData['mobilenumber'].toString(),
            password: customerData['password'].toString(),
            address: customerData['address'].toString(),
            card_details: customerData['carddetails'].toString(),
            cvv: customerData['cvv'].toString(),
            paypal_id: customerData['paypal_id'].toString(),
            aec_transfer: customerData['aectransfer'].toString(),
            card_type: customerData['cardtype'].toString(),
            card_holders_name: customerData['cardholdersname'].toString(),
            card_number: customerData['cardnumber'].toString(),
          );
          allcustomersList.add(customer);
        }

        return allcustomersList;
      } else {
        print('Failed to fetch customer data');
        throw Exception('Failed to fetch customer data');
      }
    } catch (e) {
      print('Error getting customer details: $e');
      throw Exception('Failed to fetch customer data');
    }
  }

  void _showcustomerDetailsDialog(BuildContext context, customerInfo customer) {
    // Print customer details for debugging
    // print('Customer Details:');
    // print('Username: ${customer.username}');
    // print('Email: ${customer.email}');
    // print('Mobile Number: ${customer.mobile_number}');
    // print('Address: ${customer.address}');
    // print('Card Details: ${customer.card_details}');
    // print('CVV: ${customer.cvv}');
    // print('PayPal ID: ${customer.paypal_id}');
    // print('AEC Transfer: ${customer.aec_transfer}');
    // print('Card Type: ${customer.card_type}');
    // print('Card Holder\'s Name: ${customer.card_holders_name}');
    // print('Card Number: ${customer.card_number}');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${customer.username}'),
                Text('Email: ${customer.email}'),
                Text('Mobile Number: ${customer.mobile_number}'),
                Text('Address: ${customer.address}'),
                Text('Card Details: ${customer.card_details}'),
                Text('CVV: ${customer.cvv}'),
                Text('PayPal ID: ${customer.paypal_id}'),
                Text('AEC Transfer: ${customer.aec_transfer}'),
                Text('Card Type: ${customer.card_type}'),
                Text('Card Holder\'s Name: ${customer.card_holders_name}'),
                Text('Card Number: ${customer.card_number}'),
                // Add more details here as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<customerInfo>>(
        future: _customerDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<customerInfo>? allcustomersList = snapshot.data;
            if (allcustomersList == null || allcustomersList.isEmpty) {
              return Center(child: Text('No Users found.'));
            } else {
              return ListView.builder(
                itemCount: allcustomersList.length,
                itemBuilder: (context, index) {
                  customerInfo customer = allcustomersList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(0xFFBBEEC5),
                      child: SizedBox(
                        height: 80,
                        child: Center(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person),
                            ),
                            title: Text(customer.username),
                            subtitle: Text(customer.email),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ),
                            onTap: () {
                              _showcustomerDetailsDialog(context, customer);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
