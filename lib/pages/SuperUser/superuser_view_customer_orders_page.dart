import 'dart:convert';
import 'package:ap_landscaping/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orderinfo.dart';
import '../../utilities/customer_services_card.dart';
import '../../utilities/services_loading_page.dart';

class SuperUserViewParticularCustomerOrdersPage extends StatefulWidget {
  final token;
  final superUserId;
  final customerdetails;

  const SuperUserViewParticularCustomerOrdersPage({
    required this.token,
    required this.superUserId,
    required this.customerdetails,
    Key? key
  }) : super(key: key);

  @override
  State<SuperUserViewParticularCustomerOrdersPage> createState() => _SuperUserViewParticularCustomerOrdersPageState();
}

class _SuperUserViewParticularCustomerOrdersPageState extends State<SuperUserViewParticularCustomerOrdersPage> {

  late Future<List<orderInfo>> customerAllOrders;
  @override
  void initState() {
    super.initState();
    customerAllOrders = customerGetAllOrders();
    // print(unassignedOrders);
  }

  Future<List<orderInfo>> customerGetAllOrders() async {
    final response = await http.get(
      Uri.parse('$superUserGetOrdersByCustomer${widget.customerdetails.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> ordersJson = json.decode(response.body)['orders'];
      final List<orderInfo> orders = [];
      print(ordersJson);
      for (var order in ordersJson) {
        print(order);
        print(order['providerId']);
        String providerName = "Not Assigned yet!";
        // if(order['providerId'] != null) {
        //   final providerDetails = await getProviderDetailsById(
        //       order['providerId'], widget.token);
        //   providerName = providerDetails.username;
        // }
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'].toString(),
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'] ?? "NA",
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          providerName: providerName,
          // Add other customer details as needed
        ));
        print(order);
        print("----");
      }
      // for (var order in orders) {
      //   print("Order ID: ${order.id}");
      //   print("Service Type: ${order.serviceType}");
      //   print("Address: ${order.address}");
      //   print("Date: ${order.date}");
      //   print("Time: ${order.time}");
      //   print("Expectation Note: ${order.expectationNote}");
      //   print("Customer ID: ${order.customerId}");
      //   print("Provider ID: ${order.providerId}");
      //   print("Is Finished: ${order.isFinished}");
      //   print("Is Cancelled: ${order.isCancelled}");
      //   print("Provider Name: ${order.providerName}");
      //   // Print other details as needed
      //   print("-----------------------------------");
      // }
      // print("");
      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            '${widget.customerdetails.username}\'s Orders',
            style: const TextStyle(
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
            },
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Image(
          //       image: AssetImage('assets/images/notificationsIcon.png'),
          //     ), // Notifications Bell Icon
          //     onPressed: () {
          //       // Handle notifications icon action (e.g., show notifications)
          //     },
          //   ),
          // ],
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
          // color: Colors.green[100],
          width: double.infinity,
          child: Center(
            child: RefreshIndicator(
              onRefresh: () async {
                // Implement your refresh logic here.
                // For example, you can call providerPreviousOrdersList() again.
                // await Future.delayed(
                //     const Duration(seconds: 1)); // Simulating a delay
                // setState(() {
                //   unassignedOrders = getUnassignedOrders();
                // });
                // Refresh the UI
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FutureBuilder<List<orderInfo>>(
                  future: customerAllOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ServicesLoadingPage();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Text('No orders found.');
                    } else {
                      final orders = snapshot.data;
                      return ListView.builder(
                        itemCount: orders?.length,
                        itemBuilder: (context, index) {
                          final order = orders?[index];
                          // print(order?.providerId);
                          // print(order?.date);
                          String statusText;
                          Color statusColor;
                          if (order!.isCancelled) {
                            statusText = 'Cancelled';
                            statusColor = const Color(0xFFEA2F2F);
                          } else if (order.providerId == "NA"){
                            statusText = 'Not Assigned Yet';
                            statusColor = Colors.orange;
                          } else if (order.isFinished) {
                            statusText = 'Finished';
                            statusColor = const Color(0xFF3BAE5B);
                          } else if (!order.isFinished && order.isAcceptedByProvider) {
                            statusText = 'Accepted, not yet Finished';
                            statusColor = const Color(0xFFFFE015);
                          } else {
                            statusText = 'Assigned';
                            statusColor = const Color(0xFF311E5B);
                          }
                          // print(statusText);
                          // print(statusColor);
                          // return SuperUserServicesCard(
                          //   statusColor: statusColor,
                          //   statusText: statusText,
                          //   token: widget.token,
                          //   superUserId: widget.superUserId,
                          //   order: order,
                          //   onPressed: (){
                          //     _showProvidersPopup(order!.id);
                          //   },
                          // );
                          print(widget.token);
                          print(widget.customerdetails.id);
                          print(order);
                          return CustomerMyServicesCard(
                              token: widget.token,
                              customerId: widget.customerdetails.id,
                              order: order,
                              statusText: statusText,
                              statusColor: statusColor
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}
