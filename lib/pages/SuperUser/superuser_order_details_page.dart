import 'package:ap_landscaping/models/customerinfo.dart';
import 'package:ap_landscaping/utilities/custom_spacer.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:ap_landscaping/utilities/order_details_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:shimmer/shimmer.dart';
import '../../utilities/order_details_utilities.dart';

class SuperUserOrderDetailsPage extends StatefulWidget {
  final token;
  final superUserId;
  final orderId;
  final statusText;
  final statusColor;
  const SuperUserOrderDetailsPage({Key? key,
    required this.token,
    required this.superUserId,
    required this.orderId,
    required this.statusColor,
    required this.statusText,
  }) : super(key: key);

  @override
  _SuperUserOrderDetailsPageState createState() => _SuperUserOrderDetailsPageState();
}

class _SuperUserOrderDetailsPageState extends State<SuperUserOrderDetailsPage> {

  bool receivedCustomerData = false;
  bool isLoading = true;
  bool receivedProviderData = false;
  orderInfo order = orderInfo();
  providerInfo provider_info = providerInfo();
  customerInfo customer_info = customerInfo();

  @override
  void initState() {
    super.initState();
    initialize();

  }

  void initialize() async {
    await getOrderById();
    if(order.providerId != "") {
      getProviderDetailsById();
    }
    print(customer_info.username);
    isLoading = false;

    if(order.customerId != ""){
      getCustomerDetailsById();
    }
    // print("isfinished: ${order.isFinished}");
    // print("is accepted by provider : ${order.isAcceptedByProvider}");
    print(order.providerId);
  }

  Future<void> getOrderById() async {
    try {
      final response = await http.get(
        Uri.parse('$getOrder${widget.orderId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          order.serviceType = data['order']['serviceType'] ?? '';
          order.address = data['order']['address'] ?? '';
          order.date = data['order']['date'] ?? '';
          order.time = data['order']['time'] ?? '';
          order.expectationNote = data['order']['expectationNote'] ?? '';
          order.customerId = data['order']['customerId'] ?? '';
          order.providerId = data['order']['providerId'];
          order.isFinished = data['order']['isFinished'] ?? '';
          order.isCancelled = data['order']['isCancelled'] ?? '';
          order.id = data['order']['id'] ?? '';
          // isLoading = false;
        });
      } else if (response.statusCode == 404) {
        // return {'error': 'Order not found'};
      } else {
        // return {'error': 'Failed to fetch order'};
      }
    } catch (e) {
      print('Error getting order: $e');
      // return {'error': 'Failed to fetch order'};
    }
  }

  Future<void> getProviderDetailsById() async {
    try {
      if (order.providerId != null) {
        final response = await http.get(
          Uri.parse('$providerDetailsbyId${order.providerId}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
        );
        if (response.statusCode == 200) {
          final dynamic data = json.decode(response.body);
          setState(() {
            provider_info.username = data['provider']['username'] ?? 'Not Assigned Yet!!';
            provider_info.email = data['provider']['email'] ?? 'NA';
            provider_info.mobile_number = data['provider']['mobilenumber'] ?? 'NA';
            provider_info.address = data['provider']['address'] ?? 'NA';
            provider_info.qualifications = data['provider']['qualifications'] ?? 'NA';
            provider_info.years_of_experience = data['provider']['yearsofexperience'] ?? 'NA';
            provider_info.bio = data['provider']['bio'] ?? 'NA';
            provider_info.google_id = data['provider']['googleId'] ?? 'NA';
            receivedProviderData = true;
          });
        } else if (response.statusCode == 404) {
          // Handle 404 error
        } else {
          // Handle other errors
        }
      } else {
        // Initialize to 'Not Assigned Yet!!' if providerId is null
        setState(() {
          provider_info.username = 'Not Assigned Yet!!';
          provider_info.email = 'NA';
          provider_info.mobile_number = 'NA';
          provider_info.address = 'NA';
          provider_info.qualifications = 'NA';
          provider_info.years_of_experience = 'NA';
          provider_info.bio = 'NA';
          provider_info.google_id = 'NA';
          receivedProviderData = true;
        });
      }
    } catch (e) {
      print('Error getting order: $e');
      // Handle error
    }
  }

  Future<void> getCustomerDetailsById() async {
    try {
      final response = await http.get(
        Uri.parse('$customerDetailsbyId${order.customerId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          customer_info.username = data['customer']['username'] ?? '';
          customer_info.email = data['customer']['email'] ?? '';
          customer_info.mobile_number = data['customer']['mobilenumber'] ?? '';
          // provider_info.password = data['provider']['username'] ?? '';
          customer_info.address = data['customer']['address'] ?? '';
          // provider_info.card_details = data['provider']['username'] ?? '';
          // provider_info.cvv = data['provider']['username'] ?? '';
          // provider_info.paypal_id = data['provider']['username'] ?? '';
          // provider_info.aec_transfer = data['provider']['username'] ?? '';
          // provider_info.card_type = data['provider']['username'] ?? '';
          // provider_info.card_holders_name = data['provider']['username'] ?? '';
          // provider_info.card_number = data['provider']['username'] ?? '';
          // provider_info.qualifications = data['provider']['username'] ?? '';
          // provider_info.years_of_experience =
          //     data['provider']['yearsofexperience'] ?? 0;
          // provider_info.bio = data['provider']['bio'] ?? '';
          // provider_info.bank_name = data['provider']['username'] ?? '';
          // provider_info.account_nummber = data['provider']['username'] ?? '';
          // provider_info.services = data['provider']['services'] ?? '';
          // customer_info.google_id = data['provider']['googleId'] ?? '';
          receivedCustomerData = true;
        });
      } else if (response.statusCode == 404) {
        // return {'error': 'Order not found'};
      } else {
        // return {'error': 'Failed to fetch order'};
      }
    } catch (e) {
      print('Error getting order: $e');
      // return {'error': 'Failed to fetch order'};
    }
  }

  @override
  Widget build(BuildContext context) {

    OrderDetailsUtilityWidgets detailsUtilityWidgets = OrderDetailsUtilityWidgets(order: order);

    if (isLoading) {
      return const OrderDetailsLoadingPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Image(
                image: AssetImage('assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // backgroundColor: Colors.green[900],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 16, 5, 0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          order.serviceType,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: fontHelper(context) * 28,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Date: \t ${order.date}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: fontHelper(context) * 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                'Time: \t ${order.time}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: fontHelper(context) * 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: fontHelper(context) * 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: widget.statusColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.statusText,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: fontHelper(context) * 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSpacer(width: screenWidth(context) * 0.9, padding: 5, height: 2,),
              detailsUtilityWidgets.buildDurationWidget(context),
              CustomSpacer(width: screenWidth(context) * 0.9, height: 2,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Provider : ',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: fontHelper(context) * 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEAEA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 5, 15),
                              child: Row(
                                children: [
                                  receivedProviderData
                                      ? CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.green[100],
                                    child: const Icon(
                                      Icons.person,
                                      size: 35,
                                    ),
                                  )
                                      : SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15), // Spacing between avatar and username
                                  // Username
                                  Flexible(
                                    child: receivedProviderData
                                        ? Text(
                                      provider_info.username,
                                      style: TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded, color: Color(0xFF3E363F)),
                                    const SizedBox(width: 8,),
                                    receivedProviderData
                                        ? Text(
                                      provider_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 150,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded, color: Color.fromRGBO(62, 54, 63, 1)), // Email icon
                                    const SizedBox(width: 8,),
                                    receivedProviderData
                                        ? Text(
                                      provider_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 200,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded, color: Color.fromRGBO(62, 54, 63, 1)), // Email icon
                                    const SizedBox(width: 8,),
                                    receivedProviderData
                                        ? Text(
                                      provider_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 200,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomSpacer(width: screenWidth(context) * 0.9, height: 2,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Customer : ',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: fontHelper(context) * 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEAEA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 5, 20),
                              child: Row(
                                children: [
                                  receivedCustomerData
                                      ? CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.green[100],
                                    child: const Icon(
                                      Icons.person,
                                      size: 35,
                                    ),
                                  )
                                      : SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15), // Spacing between avatar and username
                                  // Username
                                  Flexible(
                                    child: receivedCustomerData
                                        ? Text(
                                      customer_info.username,
                                      style: TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: fontHelper(context) * 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded, color: Color(0xFF3E363F)),
                                    const SizedBox(width: 8,),
                                    receivedProviderData
                                        ? Text(
                                      customer_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 150,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded, color: Color.fromRGBO(62, 54, 63, 1)), // Email icon
                                    const SizedBox(width: 8,),
                                    receivedCustomerData
                                        ? Text(
                                      customer_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 200,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded, color: Color.fromRGBO(62, 54, 63, 1)), // Email icon
                                    const SizedBox(width: 8,),
                                    receivedCustomerData
                                        ? Text(
                                      customer_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                        : Shimmer.fromColors(
                                      baseColor: Colors.green.shade100,
                                      highlightColor: Colors.green.shade50,
                                      child: Container(
                                        width: 200,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomSpacer(width: screenWidth(context) * 0.9, padding: 5, height: 2,),
              detailsUtilityWidgets.buildPriceDetails(context),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      );
    }
  }
}
