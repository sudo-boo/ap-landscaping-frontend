import 'package:ap_landscaping/pages/customer/customer_home_page.dart';
import 'package:ap_landscaping/pages/customer/customer_profile_page.dart';
import 'package:ap_landscaping/utilities/customer_services_card.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:ap_landscaping/utilities/order_details_loading_page.dart';
import 'package:ap_landscaping/utilities/services_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/providerinfo.dart';

import '../../utilities/apis.dart';
import '../../utilities/coming_soon_popup.dart';

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
        print(order);
        // print(order['providerId']);
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
      }
      // print();
      return orders;
    } else {
      print(response.statusCode);
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
        print(order);
        // print(order['providerId']);
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
      return orders;
    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  // Future<providerInfo> getProviderDetailsById(String provider_id) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$providerDetailsbyId$provider_id'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': '${widget.token}',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final dynamic data = json.decode(response.body);
  //       return providerInfo(
  //         username: data['provider']['username'] ?? '',
  //         email: data['provider']['email'] ?? '',
  //         mobile_number: data['provider']['mobilenumber'] ?? '',
  //         address: data['provider']['address'] ?? '',
  //       );
  //     } else if (response.statusCode == 404) {
  //       // return {'error': 'Order not found'};
  //       return providerInfo();
  //     } else {
  //       // return {'error': 'Failed to fetch order'};
  //       return providerInfo();
  //     }
  //   } catch (e) {
  //     print('Error getting order: $e');
  //     return providerInfo();
  //     // return {'error': 'Failed to fetch order'};
  //   }
  // }

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
              // Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerHomePage(
                          token: widget.token,
                          customerId: widget.customerId)));
            },
          ),
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: IconButton(
          //       icon: Icon(
          //           Icons.notifications_rounded,
          //         size: fontHelper(context) * 30,
          //       ),
          //       onPressed: () {
          //         // Handle notifications icon action (e.g., show notifications)
          //       },
          //     ),
          //   ),
          // ],
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
                    icon: Image.asset('assets/images/homeIcon.png',
                        height: 40, width: 40),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerHomePage(
                            token: widget.token,
                            customerId: widget.customerId
                          )
                        )
                      );
                    },
                    // onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(
                      icon: Image.asset(
                          'assets/images/myServicesPressedIcon.png',
                          height: 40, width: 40),
                      onPressed: () {
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('assets/images/communicationIcon.png',
                        height: 40, width: 40),
                    onPressed: () {showComingSoonDialog(context);},
                    // onPressed: () => _onItemTapped(3),
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/moreIcon.png',
                        height: 40, width: 40),
                    onPressed: () {
                      Navigator.pushReplacement(
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
                top: -30, // Adjust this value to position the button as needed
                child: Container(
                  height: 90, // Increase the height for a larger button
                  width: 90, // Increase the width for a larger button
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // Ensures the container is circular
                    color: Color(0xFFBCDD8C), // Background color of the button
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/centerIcon.png',
                      height: 90, // Adjust the size of the inner image/icon
                      width: 90,
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
