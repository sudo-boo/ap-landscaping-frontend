import 'dart:convert';
import 'package:ap_landscaping/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orderinfo.dart';
import '../../utilities/apis.dart';
import '../../utilities/provider_services_card.dart';
import '../../utilities/services_loading_page.dart';

class SuperUserViewParticularProviderOrdersPage extends StatefulWidget {
  final token;
  final superUserId;
  final providerId;

  const SuperUserViewParticularProviderOrdersPage({
    required this.token,
    required this.superUserId,
    required this.providerId,
    Key? key
  }) : super(key: key);

  @override
  State<SuperUserViewParticularProviderOrdersPage> createState() => _SuperUserViewParticularProviderOrdersPageState();
}

class _SuperUserViewParticularProviderOrdersPageState extends State<SuperUserViewParticularProviderOrdersPage> {

  late Future<List<orderInfo>> providerAllOrders;
  @override
  void initState() {
    super.initState();
    providerAllOrders = providerGetAllOrders();
    // print(unassignedOrders);
  }

  Future<List<orderInfo>> providerGetAllOrders() async {
    final response = await http.get(
      Uri.parse('$superUserGetOrdersByProvider${widget.providerId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> ordersJson = json.decode(response.body)['orders'];
      final List<orderInfo> orders = [];
      // print(ordersJson);
      for (var order in ordersJson) {
        print(order);
        final customerDetails = await getCustomerDetailsById(order['customerId'], widget.token);
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'].toString(),
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'],
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          isRescheduled: order['isRescheduled'] ?? false,
          customerName: customerDetails.username,
          isAcceptedByProvider: order['isAcceptedByProvider'] ?? false,
          // Add other customer details as needed
        ));
      //   print(order);
      //   print("----");
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
          title: const Text(
            'Provider\'s Orders',
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
            },
          ),
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
                setState(() {
                  providerAllOrders = providerGetAllOrders();
                });
                // Refresh the UI
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FutureBuilder<List<orderInfo>>(
                  future: providerAllOrders,
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
                          return ProviderServicesCard(
                              token: widget.token,
                              providerId: widget.providerId,
                              order: order,
                              statusText: statusText,
                              statusColor: statusColor
                          );
                        }
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
