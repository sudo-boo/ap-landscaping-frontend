

import 'dart:convert';

import '../config.dart';
import '../models/customerinfo.dart';
import '../models/providerinfo.dart';
import 'package:http/http.dart' as http;


Future<providerInfo> getProviderDetailsById(String provider_id, String token) async {
  try {
    final response = await http.get(
      Uri.parse('$providerDetailsbyId$provider_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return providerInfo(
        username: data['provider']['username'] ?? '',
        email: data['provider']['email'] ?? '',
        mobile_number: data['provider']['mobilenumber'] ?? '',
        address: data['provider']['address'] ?? '',
      );
    } else if (response.statusCode == 404) {
      // return {'error': 'Order not found'};
      return providerInfo();
    } else {
      // return {'error': 'Failed to fetch order'};
      return providerInfo();
    }
  } catch (e) {
    print('Error getting order: $e');
    return providerInfo();
    // return {'error': 'Failed to fetch order'};
  }
}

Future<customerInfo> getCustomerDetailsById(String customer_id, String token) async {
  try {
    final response = await http.get(
      Uri.parse('$customerDetailsbyId${customer_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return customerInfo(
        username: data['customer']['username'] ?? '',
        email: data['customer']['email'] ?? '',
        mobile_number: data['customer']['mobilenumber'] ?? '',
        address: data['customer']['address'] ?? '',
      );
    } else if (response.statusCode == 404) {
      // return {'error': 'Order not found'};
      return customerInfo();
    } else {
      return customerInfo();
      // return {'error': 'Failed to fetch order'};
    }
  } catch (e) {
    print('Error getting order: $e');
    return customerInfo();
    // return {'error': 'Failed to fetch order'};
  }
}

Future<List<providerInfo>> fetchAllProviderDetails(String token) async {
  try {
    print('Fetching provider details...');
    final response = await http.get(
      Uri.parse(superUserGetAllProviders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      final List<dynamic> providersData = data['providers'];

      List<providerInfo> allProvidersList = [];

      for (var providerData in providersData) {
        // print("$providerData");
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
