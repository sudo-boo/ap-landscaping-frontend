import 'dart:convert';
import 'package:ap_landscaping/pages/provider/provider_profile_page.dart';
import 'package:ap_landscaping/pages/provider/provider_home.dart';
import 'package:ap_landscaping/utilities/provider_services_card.dart';
import 'package:ap_landscaping/utilities/services_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../models/orderinfo.dart';
import '../../utilities/apis.dart';
import '../../utilities/coming_soon_popup.dart';


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
    futureorders = providerUpcomingOrdersList();
    pastorders = providerPreviousOrdersList();
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
        // print(order);
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
        // print(order);
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
        // print(order['isAcceptedByProvider']);
      }

      return orders;
    } else {
      throw Exception('Failed to load provider orders');
    }
  }

  Future<void> acceptOrDeclineOrder(BuildContext context, String orderId, String action) async {
    String message = "${action == 'accept' ? 'Accepting' : 'Declining'} Order... Please Wait..!!";
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents user from dismissing the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            width: 120,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontFamily: 'Inter'
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      final response = await http.put(
        Uri.parse(acceptOrderByProvider),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: json.encode({'action': action, 'orderId': orderId}),
      );

      Navigator.pop(context);


      if (response.statusCode == 200) {
        _showPopup(context, 'Success', 'Order ${action == 'accept' ? 'accepted' : 'declined'} successfully.!!');
      } else {
        _showPopup(context, 'Failure', 'Failed to ${action == 'accept' ? 'accept' : 'decline'} order. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      _showPopup(context, 'Error', 'Error accepting/declining order: $error');
    }
  }

  void _showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.green, // Change title color to green
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black87, // Change content text color to black
            ),
          ),
          backgroundColor: Colors.white, // Change background color to white
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.green, // Change button text color to green
                ),
              ),
              onPressed: () {
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
            ),
          ],
        );
      },
    );
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
                                  // print(order?.isFinished);
                                  // print(order?.isRescheduled);
                                  // print(order?.isCancelled);
                                  // print(order?.isAcceptedByProvider);
                                  // print("");
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
                                        acceptOrDeclineOrder(context, order.id, 'accept');
                                      },
                                      onPress2: (){
                                        acceptOrDeclineOrder(context, order.id, 'decline');
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
                      height: 35, width: 35
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
                          height: 40,
                          width: 40),
                      onPressed: () {
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('assets/images/communicationIcon.png',
                        height: 35, width: 35),
                    onPressed: () {showComingSoonDialog(context);},
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/moreIcon.png',
                        height: 35, width: 35),
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
