import 'dart:convert';
import 'package:ap_landscaping/pages/SuperUser/superuser_display_all_providers.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_view_customer_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/customerinfo.dart';
import '../../config.dart';

class SuperUserAllCustomersPage extends StatefulWidget {
  final token;
  final superUserId;
  const SuperUserAllCustomersPage({
    required this.token,
    required this.superUserId,
    Key? key
  })      : super(key: key);

  @override
  _SuperUserAllCustomersPageState createState() => _SuperUserAllCustomersPageState();
}

class _SuperUserAllCustomersPageState extends State<SuperUserAllCustomersPage> {
  late Future<List<customerInfo>> _customerDetailsFuture;

  @override
  void initState() {
    super.initState();
    _customerDetailsFuture = fetchAllcustomerDetails();
  }

  Future<List<customerInfo>> fetchAllcustomerDetails() async {
    try {
      print('Fetching customer details...');
      print(widget.token);
      final response = await http.get(
        Uri.parse(superUserGetAllUsers),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      // Debug: Print response status code and body
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> customersData = data['customers'];

        List<customerInfo> allcustomersList = [];

        for (var customerData in customersData) {
          print('Customer data: $customerData');
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
            id: customerData['id'].toString(),
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
    print('Customer Details:');
    print('Username: ${customer.username}');
    print('Customer ID: ${customer.id}');
    print('Email: ${customer.email}');
    print('Mobile Number: ${customer.mobile_number}');
    print('Address: ${customer.address}');
    print('Card Details: ${customer.card_details}');
    print('CVV: ${customer.cvv}');
    print('PayPal ID: ${customer.paypal_id}');
    print('AEC Transfer: ${customer.aec_transfer}');
    print('Card Type: ${customer.card_type}');
    print('Card Holder\'s Name: ${customer.card_holders_name}');
    print('Card Number: ${customer.card_number}');


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
          'Customer Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoWidget(
                  label: 'Username:',
                  value: customer.username,
                ),
                InfoWidget(
                  label: 'Customer ID:',
                  value: customer.id,
                ),
                InfoWidget(
                  label: 'Email:',
                  value: customer.email,
                ),
                InfoWidget(
                  label: 'Mobile Number:',
                  value: customer.mobile_number,
                ),
                InfoWidget(
                  label: 'Address:',
                  value: customer.address,
                ),
                InfoWidget(
                  label: 'Card Details:',
                  value: customer.card_details,
                ),
                InfoWidget(
                  label: 'CVV:',
                  value: customer.cvv,
                ),
                InfoWidget(
                  label: 'PayPal ID:',
                  value: customer.paypal_id,
                ),
                InfoWidget(
                  label: 'AEC Transfer:',
                  value: customer.aec_transfer,
                ),
                InfoWidget(
                  label: 'Card Type:',
                  value: customer.card_type,
                ),
                InfoWidget(
                  label: 'Card Holder\'s Name:',
                  value: customer.card_holders_name,
                ),
                InfoWidget(
                  label: 'Card Number:',
                  value: customer.card_number,
                ),
                // Add more InfoWidget instances as needed
              ],

            ),
          ),
          actions: [Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // _onItemTapped(1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuperUserViewParticularCustomerOrdersPage(
                              token: widget.token,
                            superUserId: widget.superUserId,
                            customerdetails: customer,
                          )
                      )
                  );
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                      padding: const EdgeInsets.all(15), // Adjust padding as needed
                      child: const Row(
                        children: [
                          Text(
                            'View Orders',
                            style: TextStyle(
                              color: Colors.green, // Text color is white for better visibility
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
