import 'package:ap_landscaping/pages/customer/customerHome.dart';
import 'package:ap_landscaping/pages/customer/order_details.dart';
import 'package:ap_landscaping/pages/customer/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/providerinfo.dart';

class myServicesPage extends StatefulWidget {
  final token;
  final customerId;
  const myServicesPage(
      {required this.token, required this.customerId, Key? key})
      : super(key: key);
  @override
  State<myServicesPage> createState() => _myServicesPageState();
}

class _myServicesPageState extends State<myServicesPage> {
  // Future<List<orderInfo>> customerOrdersList() async {
  //   final response = await http.get(
  //     Uri.parse('$customerOrders${widget.customerId}'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': '${widget.token}',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final List<dynamic> ordersJson = json.decode(response.body)['orders'];
  //     final List<orderInfo> orders = ordersJson.map((order) {
  //       return orderInfo(
  //           serviceType: order['serviceType'],
  //           address: order['address'],
  //           date: order['date'],
  //           time: order['time'],
  //           expectationNote: order['expectationNote'].toString(),
  //           customerId: order['customerId'],
  //           providerId: order['providerId'],
  //           isFinished: order['isFinished'],
  //           isCancelled: order['isCancelled'],
  //           id: order['id']);
  //     }).toList();
  //     // print();
  //     return orders;
  //   } else {
  //     throw Exception('Failed to load customer orders');
  //   }
  // }

  late Future<List<orderInfo>> pastorders;
  late Future<List<orderInfo>> futureorders;

  @override
  void initState() {
    super.initState();
    // Initial call to providerPreviousOrdersList
    pastorders = customerPreviousOrdersList();
    futureorders = customerUpcomingOrdersList();
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
        final providerDetails =
        await getProviderDetailsById(order['providerId']);
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'],
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'],
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          providerName: providerDetails.username,
          // Add other customer details as needed
        ));
      }
      // print();
      return orders;
    } else {
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
        if(order['providerId'] != null){
          final providerDetails =
          await getProviderDetailsById(order['providerId']);
          orders.add(orderInfo(
            serviceType: order['serviceType'],
            address: order['address'],
            date: order['date'],
            time: order['time'],
            expectationNote: order['expectationNote'].toString(),
            customerId: order['customerId'],
            providerId: order['providerId'] ?? "Not Assigned",
            isFinished: order['isFinished'],
            isCancelled: order['isCancelled'],
            id: order['id'],
            providerName: providerDetails.username,
            // Add other customer details as needed
          ));
        }
        else{
          orders.add(orderInfo(
            serviceType: order['serviceType'],
            address: order['address'],
            date: order['date'],
            time: order['time'],
            expectationNote: order['expectationNote'].toString(),
            customerId: order['customerId'],
            providerId: order['providerId'] ?? "Not Assigned",
            isFinished: order['isFinished'],
            isCancelled: order['isCancelled'],
            id: order['id'],
            providerName: "Not Assigned yet!",
            // Add other customer details as needed
          ));
        }
      }
      // print();
      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  Future<providerInfo> getProviderDetailsById(String provider_id) async {
    try {
      final response = await http.get(
        Uri.parse('$providerDetailsbyId${provider_id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // title: Text(widget.serviceName),
          title: const Text(
            'My Services',
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
          actions: <Widget>[
            IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/notificationsIcon.png'),
              ), // Notifications Bell Icon
              onPressed: () {
                // Handle notifications icon action (e.g., show notifications)
              },
            ),
          ],
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
                    fontSize: 16,
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
                    fontSize: 16,
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
                Container(
                  // color: Colors.green[100],
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
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
                              return const CircularProgressIndicator();
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
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(children: [
                                      Card(
                                        color: const Color(0xFFCEF29B),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  order.serviceType,
                                                  // textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Color(0xFF1C1F34),
                                                    fontSize: 24,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    24.0, 40.0, 24.0, 24.0),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Date',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order!.date,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Time',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.time,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Provider',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerName,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Payment mode',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerId,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    // ListTile(
                                                    //   title: Text(
                                                    //     order.serviceType,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    //   subtitle: Text(
                                                    //     order.date,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OrderDetailsPage(
                                                                      token:
                                                                      widget.token,
                                                                      customerId: widget
                                                                          .customerId,
                                                                      orderId: order.id,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                            Colors.green[900],
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
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
                                      Positioned(
                                        top: 69,
                                        left: 30,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
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
                Container(
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
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
                              return const CircularProgressIndicator();
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
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(children: [
                                      Card(
                                        color: const Color(0xFFCEF29B),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  order.serviceType,
                                                  // textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Color(0xFF1C1F34),
                                                    fontSize: 24,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    24.0, 40.0, 24.0, 24.0),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Date',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order!.date,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Time',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.time,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Provider',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerName,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.maxFinite,
                                                      height: 1,
                                                      decoration: ShapeDecoration(
                                                        color:
                                                        const Color(0xFF3E363F),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Payment mode',
                                                          style: TextStyle(
                                                            color:
                                                            Color(0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.providerId,
                                                          textAlign:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    // ListTile(
                                                    //   title: Text(
                                                    //     order.serviceType,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    //   subtitle: Text(
                                                    //     order.date,
                                                    //     textAlign: TextAlign.center,
                                                    //   ),
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OrderDetailsPage(
                                                                      token:
                                                                      widget.token,
                                                                      customerId: widget
                                                                          .customerId,
                                                                      orderId: order.id,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                            Colors.green[900],
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
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
                                      Positioned(
                                        top: 69,
                                        left: 30,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            statusText,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none, // Allows the child to overflow the stack
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('lib/assets/images/homeIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => customerPage(
                                  token: widget.token,
                                  customerId: widget.customerId)));
                    },
                    // onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                      icon: Image.asset(
                          'lib/assets/images/myServicesPressedIcon.png',
                          height: 45,
                          width: 45),
                      onPressed: () {
                        // _onItemTapped(1);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => myServicesPage(
                        //             token: widget.token,
                        //             customerId: widget.customerId)));
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('lib/assets/images/communicationIcon.png',
                        height: 45, width: 45),
                    onPressed: () {},
                    // onPressed: () => _onItemTapped(3),
                  ),
                  IconButton(
                    icon: Image.asset('lib/assets/images/moreIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => profilePage(
                              token: widget.token,
                              customerId: widget.customerId),
                        ),
                      );
                    },
                    // onPressed: () => _onItemTapped(4),
                  ),
                ],
              ),
              Positioned(
                top: -35, // Adjust this value to position the button as needed
                child: Container(
                  height: 100, // Increase the height for a larger button
                  width: 100, // Increase the width for a larger button
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // Ensures the container is circular
                    color: Color(0xFFBCDD8C), // Background color of the button
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'lib/assets/images/centerIcon.png',
                      height: 100, // Adjust the size of the inner image/icon
                      width: 100,
                    ),
                    onPressed: () {},
                    // onPressed: () => _onItemTapped(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
