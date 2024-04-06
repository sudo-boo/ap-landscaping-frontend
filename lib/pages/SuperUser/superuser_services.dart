import 'package:ap_landscaping/pages/SuperUser/superuser_home.dart';
import 'package:ap_landscaping/utilities/superuser_services_card.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/models/providerinfo.dart';

class SuperUserServicesPage extends StatefulWidget {
  final token;
  final superUserId;
  const SuperUserServicesPage({
    required this.token,
    required this.superUserId,
    Key? key
  }) : super(key: key);

  @override
  State<SuperUserServicesPage> createState() => _SuperUserServicesPageState();
}

class _SuperUserServicesPageState extends State<SuperUserServicesPage> {

  List<providerInfo> allProvidersList = [];
  late Future<List<orderInfo>> pastorders;
  late Future<List<orderInfo>> futureorders;

  @override
  void initState() {
    super.initState();
    // Initial call to providerPreviousOrdersList
    pastorders = superUserGetOrders();
    futureorders = superUserGetOrders();
  }

  Future<List<orderInfo>> superUserGetOrders() async {
    try {
      // print('Fetching orders...');
      final response = await http.get(
        Uri.parse(superUserGetOrdersWithNoProviders),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );
      // print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        dynamic decodedData = json.decode(response.body);
        // print('Decoded data: $decodedData');
        final List<dynamic>? ordersJson = decodedData != null ? decodedData['orders'] : null;
        if (ordersJson != null) {
          final List<orderInfo> orders = [];
          for (var order in ordersJson) {
            // print('Processing order: $order');
            // print('Provider ID: ${order['providerId']}');
              // print('Fetching provider details for order...');
              // print('Provider details received: $providerDetails');
              orders.add(orderInfo(
                serviceType: order['serviceType'],
                address: order['address'],
                date: order['date'],
                time: order['time'],
                expectationNote: order['expectationNote'] != null ? order['expectationNote'].toString() : '',
                customerId: order['customerId'],
                providerId: order['providerId'] ?? "Not Assigned",
                isFinished: order['isFinished'],
                isCancelled: order['isCancelled'],
                id: order['id'],
                orderId: order['orderId'] ?? "",
                providerName: "Not Assigned yet!",
              ));
          }
          return orders;
        } else {
          print('No orders found.');
          return [];
        }
      } else {
        throw Exception('Failed to load customer orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  Future<void> assignProvider(String orderId, String providerId) async {
    try {
      final response = await http.post(
          Uri.parse(superUserAssignProvider),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: jsonEncode({
            "orderId": orderId,
            "providerId": providerId,
          })
      );
      if (response.statusCode == 200) {
        print("Request successful");
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      // Handle error
    }
  }


  void _showProvidersPopup(String orderId) {
    providerInfo? selectedProvider;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (allProvidersList.isEmpty) {
              // Fetch providers only if the list is empty
              fetchAllProviderDetails().then((providers) {
                setState(() {
                  allProvidersList = providers;
                });
              });
            }

            return AlertDialog(
              title: Text(
                'Select Provider',
                style: TextStyle(
                  color: Colors.blue, // Text color of the title
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: allProvidersList.map((provider) {
                    return ListTile(
                      leading: Icon(
                          Icons.account_circle,
                        size: 40,
                      ), // Profile icon
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.username),
                          Text(
                            'ID: ${provider.id}',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Radio<providerInfo>(
                        value: provider,
                        groupValue: selectedProvider,
                        onChanged: (provider) {
                          setState(() {
                            selectedProvider = provider;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedProvider = provider;
                        });
                      },
                    );
                  }).toList(),

                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedProvider != null) {
                      print('Selected Provider: ${selectedProvider!.username}');
                      print("OrderID: $orderId");
                      print('ProviderID: ${selectedProvider!.id}');

                      await assignProvider(orderId, selectedProvider!.id); // Wait for the function to complete

                      // Navigate to another page after the assignment is done
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => SuperUserServicesPage(
                            token: widget.token,
                            superUserId: widget.superUserId,
                          ),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a provider')),
                      );
                    }
                  },
                  child: Text('Select'),
                ),
              ],
            );

          },
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
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
              image: AssetImage('assets/images/backIcon.png'),
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuperUserPage(
                          token: widget.token,
                          superuserId: widget.superUserId)));
            },
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
                SizedBox(
                  // color: Colors.green[100],
                  width: double.infinity,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // Implement your refresh logic here.
                        // For example, you can call providerPreviousOrdersList() again.
                        await Future.delayed(
                            const Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          futureorders = superUserGetOrders();
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
                                  return SuperUserServicesCard(
                                      token: widget.token,
                                      superUserId: widget.superUserId,
                                      order: order,
                                      onPressed: (){
                                        _showProvidersPopup(order!.id);
                                      },
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
                        await Future.delayed(
                            const Duration(seconds: 1)); // Simulating a delay
                        setState(() {
                          // pastorders = customerPreviousOrdersList();
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
                                  return SuperUserServicesCard(
                                      token: widget.token,
                                      superUserId: widget.superUserId,
                                      order: order,
                                      onPressed: (){
                                        _showProvidersPopup(order.id);
                                      },
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
                        height: 45, width: 45),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuperUserPage(
                                  token: widget.token,
                                  superuserId: widget.superUserId
                              )
                          )
                      );
                    },
                    // onPressed: () => _onItemTapped(0),
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
                    // onPressed: () => _onItemTapped(3),
                  ),
                  IconButton(
                    icon: Image.asset('assets/images/moreIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
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