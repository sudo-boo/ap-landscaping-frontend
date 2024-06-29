import 'package:ap_landscaping/utilities/customer_services_card.dart';
import 'package:ap_landscaping/utilities/services_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';

class CustomerServicesPage extends StatefulWidget {
  final token;
  final customerId;
  const CustomerServicesPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);
  @override
  State<CustomerServicesPage> createState() => _CustomerServicesPageState();
}

class _CustomerServicesPageState extends State<CustomerServicesPage> {

  late Future<List<orderInfo>> pastorders;
  late Future<List<orderInfo>> futureorders;

  @override
  void initState() {
    super.initState();
    // Initial call to providerPreviousOrdersList
    futureorders = customerUpcomingOrdersList();
    pastorders = customerPreviousOrdersList();
  }

  Future<List<orderInfo>> customerPreviousOrdersList() async {
    final response = await http.get(
      Uri.parse(customerPastOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson = json.decode(response.body)['pastOrders'];
      final List<orderInfo> orders = [];
      for (var order in ordersJson) {
        // print(order);
        // print(order['providerId']);
        String providerName = "Not Assigned yet!";
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
      }

      orders.sort((a, b) => b.date.compareTo(a.date));
      // print();
      return orders;
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load customer orders');
    }
  }

  Future<List<orderInfo>> customerUpcomingOrdersList() async {
    final response = await http.get(
      Uri.parse(customerUpcomingOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson =
      json.decode(response.body)['upcomingOrders'];
      final List<orderInfo> orders = [];
      for (var order in ordersJson) {
        // print(order);
        // print(order['providerId']);
        String providerName = "Not Assigned yet!";
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
      // print();

      orders.sort((a, b) => b.date.compareTo(a.date));

      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: const Text(
            'My Services',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                // text: 'Upcoming',
              ),
              Tab(
                child: Text(
                  'Past',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                // text: 'Past',
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                SizedBox(
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
                          futureorders = customerUpcomingOrdersList();
                        });
                        // Refresh the UI
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FutureBuilder<List<orderInfo>>(
                          future: futureorders,
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
                                    statusColor = const Color(0xFF714AC0);
                                  }
                                  return CustomerMyServicesCard(
                                    token: widget.token,
                                    customerId: widget.customerId,
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
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        // await Future.delayed(
                        //     const Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          pastorders = customerPreviousOrdersList();
                        });
                        // Refresh the UI
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FutureBuilder<List<orderInfo>>(
                          future: pastorders,
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
                                  String statusText;
                                  Color statusColor;
                                  if (order!.isCancelled) {
                                    statusText = 'Cancelled';
                                    statusColor = const Color(0xFFEA2F2F);
                                  } else if (order.isFinished) {
                                    statusText = 'Finished';
                                    statusColor = const Color(0xFF3BAE5B);
                                  } else {
                                    statusText = 'Pending';
                                    statusColor = Colors.orange;
                                  }
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
                                    statusColor = const Color(0xFF714AC0);
                                  }
                                  return CustomerMyServicesCard(
                                    token: widget.token,
                                    customerId: widget.customerId,
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
