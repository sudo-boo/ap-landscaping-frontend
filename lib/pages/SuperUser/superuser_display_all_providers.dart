import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/providerinfo.dart';
import '../../config.dart';

class SuperUserAllProvidersPage extends StatefulWidget {
  final token;
  final superUserId;
  const SuperUserAllProvidersPage({
    required this.token,
    required this.superUserId,
    Key? key
  })      : super(key: key);
  @override
  _SuperUserAllProvidersPageState createState() => _SuperUserAllProvidersPageState();
}

class _SuperUserAllProvidersPageState extends State<SuperUserAllProvidersPage> {
  late Future<List<providerInfo>> _providerDetailsFuture;

  @override
  void initState() {
    super.initState();
    _providerDetailsFuture = fetchAllProviderDetails();
  }


  Future<List<providerInfo>> fetchAllProviderDetails() async {
    try {
      print('Fetching provider details...');
      final response = await http.get(
        Uri.parse(superUserGetAllProviders),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> providersData = data['providers'];

        List<providerInfo> allProvidersList = [];

        for (var providerData in providersData) {
          print("$providerData");
          providerInfo provider = providerInfo(
            id: providerData['id'].toString(),
            username: providerData['username'].toString(),
            email: providerData['email'].toString(),
            mobile_number: providerData['mobilenumber'].toString(),
            password: providerData['password'].toString(),
            address: providerData['address'].toString(),
            card_details: providerData['carddetails'].toString(),
            cvv: providerData['cvv'].toString(),
            paypal_id: providerData['paypal_id'].toString(),
            aec_transfer: providerData['aectransfer'].toString(),
            card_type: providerData['cardtype'].toString(),
            card_holders_name: providerData['cardholdersname'].toString(),
            card_number: providerData['cardnumber'].toString(),
          );
          allProvidersList.add(provider);
        }

        return allProvidersList;
      } else {
        print('Failed to fetch provider data');
        throw Exception('Failed to fetch provider data');
      }
    } catch (e) {
      print('Error getting provider details: $e');
      throw Exception('Failed to fetch provider data');
    }
  }

  void _showproviderDetailsDialog(BuildContext context, providerInfo provider) {
    // Print provider details for debugging
    // print('Customer Details:');
    // print('Username: ${provider.username}');
    // print('Email: ${provider.email}');
    // print('Mobile Number: ${provider.mobile_number}');
    // print('Address: ${provider.address}');
    // print('Card Details: ${provider.card_details}');
    // print('CVV: ${provider.cvv}');
    // print('PayPal ID: ${provider.paypal_id}');
    // print('AEC Transfer: ${provider.aec_transfer}');
    // print('Card Type: ${provider.card_type}');
    // print('Card Holder\'s Name: ${provider.card_holders_name}');
    // print('Card Number: ${provider.card_number}');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Provider Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${provider.username}'),
                Text('ID: ${provider.id}'),
                Text('Email: ${provider.email}'),
                Text('Mobile Number: ${provider.mobile_number}'),
                Text('Address: ${provider.address}'),
                Text('Card Details: ${provider.card_details}'),
                Text('CVV: ${provider.cvv}'),
                Text('PayPal ID: ${provider.paypal_id}'),
                Text('AEC Transfer: ${provider.aec_transfer}'),
                Text('Card Type: ${provider.card_type}'),
                Text('Card Holder\'s Name: ${provider.card_holders_name}'),
                Text('Card Number: ${provider.card_number}'),
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
        title: Text('Providers'),
      ),
      body: FutureBuilder<List<providerInfo>>(
        future: _providerDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<providerInfo>? allprovidersList = snapshot.data;
            if (allprovidersList == null || allprovidersList.isEmpty) {
              return Center(child: Text('No providers found.'));
            } else {
              return ListView.builder(
                itemCount: allprovidersList.length,
                itemBuilder: (context, index) {
                  providerInfo provider = allprovidersList[index];
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
                            title: Text(provider.username),
                            subtitle: Text(provider.email),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ),
                            onTap: () {
                              _showproviderDetailsDialog(context, provider);
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
