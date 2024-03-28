import 'dart:convert';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';
import 'package:ap_landscaping/pages/provider/provider_home.dart';
import 'package:ap_landscaping/utilities/provider_services_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../models/customerinfo.dart';
import '../../models/orderinfo.dart';


class ProviderMyServicesPage extends StatefulWidget {
  final token;
  final providerId;
  const ProviderMyServicesPage(
      {required this.token, required this.providerId, Key? key})
      : super(key: key);
  @override
  State<ProviderMyServicesPage> createState() => _ProviderMyServicesPageState();
}

class _ProviderMyServicesPageState extends State<ProviderMyServicesPage> {
  late Future<List<orderInfo>> pastorders;
  late Future<List<orderInfo>> futureorders;

  @override
  void initState() {
    super.initState();
    // Initial call to providerPreviousOrdersList
    pastorders = providerPreviousOrdersList();
    futureorders = providerUpcomingOrdersList();
  }

  Future<List<orderInfo>> providerPreviousOrdersList() async {
    final response = await http.get(
      Uri.parse(providerPastOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson = json.decode(response.body)['pastOrders'];
      final List<orderInfo> orders = [];

      for (var order in ordersJson) {
        final customerDetails =
        await getCustomerDetailsById(order['customerId']);
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
          customerName: customerDetails.username,
          isAcceptedByProvider: order['isAcceptedByProvider'] ?? false,
          // Add other customer details as needed
        ));
      }
      return orders;
    } else {
      throw Exception('Failed to load provider orders');
    }
  }

  Future<List<orderInfo>> providerUpcomingOrdersList() async {
    final response = await http.get(
      Uri.parse(providerUpcomingOrders),
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
        final customerDetails =
        await getCustomerDetailsById(order['customerId']);
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
          customerName: customerDetails.username,
          isAcceptedByProvider: order['isAcceptedByProvider'] ?? false,
          // Add other customer details as needed
        ));
      }

      return orders;
    } else {
      throw Exception('Failed to load provider orders');
    }
  }

  Future<customerInfo> getCustomerDetailsById(String customer_id) async {
    try {
      final response = await http.get(
        Uri.parse('$customerDetailsbyId${customer_id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
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

  Future<void> acceptOrDeclineOrder(String orderId, String action) async {
    try {
      final response = await http.put(
        Uri.parse(
            acceptOrderByProvider),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: json.encode({'action': action, 'orderId' : orderId}),
      );
      if (response.statusCode == 200) {
        print('Order ${action == 'accept' ? 'accepted' : 'declined'} successfully');
      } else {
        print('Failed to ${action == 'accept' ? 'accept' : 'decline'} order. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error accepting/declining order: $error');
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
          actions: <Widget>[
            IconButton(
              icon: const Image(
                image: AssetImage('assets/images/notificationsIcon.png'),
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
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          futureorders = providerUpcomingOrdersList();
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
                                  if (!order!.isAcceptedByProvider) {
                                    statusText = 'Not Accepted Yet';
                                    statusColor = Colors.orange;
                                  } else if (order.isCancelled) {
                                    statusText = 'Cancelled';
                                    statusColor = const Color(0xFFEA2F2F);
                                  } else if (order.isFinished) {
                                    statusText = 'Finished';
                                    statusColor = const Color(0xFF3BAE5B);
                                  } else {
                                    statusText = 'Pending';
                                    statusColor = Colors.orange;
                                  }
                                  if (order.isAcceptedByProvider) {
                                    return ProviderServicesCard(
                                        token: widget.token,
                                        providerId: widget.providerId,
                                        order: order,
                                        statusText: statusText,
                                        statusColor: statusColor
                                    );
                                  } else {
                                    return ProviderServicesCard(
                                      token: widget.token,
                                      providerId: widget.providerId,
                                      order: order,
                                      statusText: statusText,
                                      statusColor: statusColor,
                                      isAccepted: false,
                                      onPress1: (){
                                        acceptOrDeclineOrder(order.id, 'accept');
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProviderMyServicesPage(
                                              token: widget.token,
                                              providerId: widget.providerId
                                            )
                                          )
                                        );
                                      },
                                      onPress2: (){
                                        acceptOrDeclineOrder(order.id, 'decline');
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProviderMyServicesPage(
                                              token: widget.token,
                                              providerId: widget.providerId
                                            )
                                          )
                                        );
                                      },
                                    );
                                  }
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
                        await Future.delayed(const Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          pastorders = providerPreviousOrdersList();
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
                                  return ProviderServicesCard(
                                      token: widget.token,
                                      providerId: widget.providerId,
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
                    icon: Image.asset(
                      'assets/images/homeIcon.png',
                      height: 45, width: 45
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderPage(
                            token: widget.token,
                            providerId: widget.providerId
                          )
                        )
                      );},
                  ),
                  IconButton(
                      icon: Image.asset(
                          'assets/images/myServicesPressedIcon.png',
                          height: 45,
                          width: 45),
                      onPressed: () {
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('assets/images/communicationIcon.png',
                        height: 45, width: 45),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/moreIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderProfilePage(
                              token: widget.token,
                              providerId: widget.providerId),
                        ),
                      );
                    },
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
                      'assets/images/centerIcon.png',
                      height: 100, // Adjust the size of the inner image/icon
                      width: 100,
                    ),
                    onPressed: () {},
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
