import 'dart:convert';

import 'package:ap_landscaping/config.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_home.dart';
import 'package:ap_landscaping/pages/SuperUser/superuser_services_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/orderinfo.dart';
import '../../models/providerinfo.dart';
import '../../utilities/apis.dart';
import '../../utilities/helper_functions.dart';
import '../../utilities/services_loading_page.dart';
import '../../utilities/superuser_services_card.dart';

class SuperUserAssignServicesPage extends StatefulWidget {
  final token;
  final superUserId;
  const SuperUserAssignServicesPage({
    required this.token,
    required this.superUserId,
    Key? key
  }) : super(key: key);

  @override
  State<SuperUserAssignServicesPage> createState() => _SuperUserAssignServicesPageState();
}

class _SuperUserAssignServicesPageState extends State<SuperUserAssignServicesPage> {

  List<providerInfo> allProvidersList = [];
  late Future<List<orderInfo>> unassignedOrders;

  @override
  void initState() {
    super.initState();
    unassignedOrders = getUnassignedOrders();
    // print(unassignedOrders);
  }

  Future<List<orderInfo>> getUnassignedOrders() async {
    try {
      final response = await http.get(
        Uri.parse(superUserGetOrdersWithNoProviders),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        dynamic decodedData = json.decode(response.body);
        // print('Decoded data: $decodedData');
        final List<dynamic>? ordersJson = decodedData != null ? decodedData['orders'] : null;
        if (ordersJson != null) {
          final List<orderInfo> orders = [];
          for (var order in ordersJson) {
            // print(order);
            // Skip order if customerId is not a string
            // if (order['customerId'] is! String) {
            //   print('Skipping order due to invalid customerId format: ${order['customerId']}');
            //   continue;
            // }

            if (!order['isCancelled']){
              orders.add(orderInfo(
                serviceType: order['serviceType'],
                address: order['address'].toString(),
                date: order['date'],
                time: order['time'],
                expectationNote: order['expectationNote'] != null ? order['expectationNote'].toString() : '',
                customerId: order['customerId'],
                providerId: order['providerId'] ?? "NA",
                isFinished: order['isFinished'],
                isCancelled: order['isCancelled'],
                id: order['id'],
                orderId: order['orderId'] ?? "",
                providerName: 'NA',
              ));
            }
            // print(customerDetails.username);
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

  Future<void> assignProvider(String orderId, providerInfo? providerInfo1, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(superUserAssignProvider),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: jsonEncode({
          "orderId": orderId,
          "providerId": providerInfo1!.id,
        }),
      );
      if (response.statusCode == 200) {
        // print("Request successful");
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Success",
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              content: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF1C1F34),
                    fontSize: fontHelper(context) * 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "Order successfully assigned to Provider ",
                      style: TextStyle(
                        color: Color(0xFF1C1F34),
                        fontSize: fontHelper(context) * 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    TextSpan(
                      text: "${providerInfo1.username}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigate to another page after the assignment is done
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => SuperUserAssignServicesPage(
                          token: widget.token,
                          superUserId: widget.superUserId,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        print("Request failed with status: ${response.statusCode}");
        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to assign provider. Please try again later."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An unexpected error occurred. Please try again later."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
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
              fetchAllProviderDetails(widget.token).then((providers) {
                setState(() {
                  allProvidersList = providers;
                });
              });
            }
            return AlertDialog(
              title: const Text(
                'Select Provider',
                style: TextStyle(
                  color: Colors.green, // Text color of the title
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: allProvidersList.map((provider) {
                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      child: SizedBox( // Wrap ListTile with SizedBox
                        width: double.infinity, // Set width to match parent width
                        child: ListTile(
                          leading: const Icon(
                            Icons.account_circle_rounded,
                            size: 35,
                            color: Colors.black,
                          ),
                          title: Text(
                            provider.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter'
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${provider.id}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              fontFamily: 'Inter'
                            ),
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
                        ),
                      ),
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
                      // print('Selected Provider: ${selectedProvider!.username}');
                      // print("OrderID: $orderId");
                      // print('ProviderID: ${selectedProvider!.id}');

                      await assignProvider(orderId, selectedProvider, context); // Wait for the function to complete
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Assign Orders',
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => SuperUserPage(
                        token: widget.token,
                        superuserId: widget.superUserId
                    )
                ),
                    (Route<dynamic> route) => false,
              );
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
                await Future.delayed(
                    const Duration(seconds: 1)); // Simulating a delay
                setState(() {
                  unassignedOrders = getUnassignedOrders();
                });
                // Refresh the UI
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FutureBuilder<List<orderInfo>>(
                  future: unassignedOrders,
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
                          return SuperUserServicesCard(
                            statusColor: statusColor,
                            statusText: statusText,
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
        )
    );
  }
}
