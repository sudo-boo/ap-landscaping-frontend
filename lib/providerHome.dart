import 'package:ap_landscaping/models/crewinfo.dart';
import 'package:ap_landscaping/models/customerinfo.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:ap_landscaping/pages/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'package:ap_landscaping/models/orderinfo.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class providerPage extends StatefulWidget {
  final token;
  final providerId;
  const providerPage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<providerPage> createState() => _providerPageState();
}

class _providerPageState extends State<providerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.person), // Profile Icon
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 200,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => crewPage(
                          token: widget.token, providerId: widget.providerId)));
            },
            child: Card(
              color: const Color.fromRGBO(229, 255, 218, 1),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Crew'),
                    IconButton(
                      icon: const Image(
                        image: AssetImage('lib/assets/images/crewPageIcon.png'),
                      ),
                      onPressed: () {},
                      // onPressed: () {}
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                  icon: Image.asset('lib/assets/images/homePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  providerId: widget.providerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
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
                            token: widget.token, providerId: widget.providerId),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class crewPage extends StatefulWidget {
  final token;
  final providerId;

  const crewPage({super.key, this.token, this.providerId});
  @override
  State<crewPage> createState() => _crewPageState();
}

class _crewPageState extends State<crewPage> {
  Future<List<crewInfo>> crewMembersList() async {
    final response = await http.get(
      Uri.parse(crewListByProvider),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> crewJson = json.decode(response.body)['crews'];
      final List<crewInfo> crewMembers = crewJson.map((crewMember) {
        print(crewMember['yearsofexperience']);
        return crewInfo(
            fullname: crewMember['yearsofexperience'] ?? '',
            username: crewMember['username'] ?? '',
            email: crewMember['email'] ?? '',
            mobilenumber: crewMember['mobilenumber'] ?? '',
            city: crewMember['address'] ?? '',
            expertise: crewMember['qualifications'] ?? '',
            id: crewMember['id']);
      }).toList();
      return crewMembers;
    } else {
      throw Exception('Failed to load provider orders');
    }
  }

  Future<void> deleteCrew(String crewId) async {
    try {
      final response = await http.delete(
        Uri.parse(crewDelete + crewId),
        headers: {
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        print('Crew deleted successfully');
      } else if (response.statusCode == 404) {
        print('Crew not found');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error deleting crew: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Crew',
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
                image: AssetImage('lib/assets/images/addCrewIcon.png'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addCrewPage(
                        token: widget.token, providerId: widget.providerId),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<crewInfo>>(
            future: crewMembersList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No crew members found.');
              } else {
                final crewMembers = snapshot.data;
                return ListView.builder(
                    itemCount: crewMembers?.length,
                    itemBuilder: (context, index) {
                      final crewMember = crewMembers?[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        crewMember!.username,
                                        style: const TextStyle(
                                          color: Color(0xFF3E363F),
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              const Icon(Icons.email_rounded,
                                                  color: Color(0xFF3E363F)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.email,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                  Icons.location_on_rounded,
                                                  color: Color.fromRGBO(62, 54,
                                                      63, 1)), // Email icon
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.city,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const Icon(Icons.call_rounded,
                                                  color: Color.fromRGBO(62, 54,
                                                      63, 1)), // Email icon
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.mobilenumber,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            deleteCrew(crewMember.id);
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => crewPage(
                                                  token: widget.token,
                                                  providerId: widget.providerId,
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFA686FF),
                                          ),
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}

class addCrewPage extends StatefulWidget {
  final token;
  final providerId;

  const addCrewPage({super.key, this.token, this.providerId});
  @override
  State<addCrewPage> createState() => _addCrewPageState();
}

class _addCrewPageState extends State<addCrewPage> {
  crewInfo crew_info = crewInfo();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> createCrew() async {
    var data = {
      "username": crew_info.username,
      "email": crew_info.email,
      "mobilenumber": crew_info.mobilenumber,
      "address": crew_info.city,
      "qualifications": crew_info.expertise,
      "yearsofexperience": crew_info.fullname,
    };
    try {
      final response = await http.post(
        Uri.parse(crewCreate),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response: $responseData');
      } else {
        print('Error: ${response.statusCode}');
        print('Error Body: ${response.body}');
      }
    } catch (error) {
      print('Error creating crew: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Add Crew',
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
        // backgroundColor: Colors.green[900],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.fullname = value ?? '',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your full name' : null,
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.username = value ?? '',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your username' : null,
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.email = value ?? '',
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your email address'
                          : null,
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.mobilenumber = value ?? '',
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.city = value ?? '',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your city' : null,
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromRGBO(255, 234, 234, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expertise',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) => crew_info.expertise = value ?? '',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your expertise' : null,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!
                            .save(); // This triggers the onSaved callback for each TextFormField
                        createCrew();
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 327,
                      height: 56,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFA686FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Add Crew',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.07,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class myServicesPage extends StatefulWidget {
  final token;
  final providerId;
  const myServicesPage(
      {required this.token, required this.providerId, Key? key})
      : super(key: key);
  @override
  State<myServicesPage> createState() => _myServicesPageState();
}

class _myServicesPageState extends State<myServicesPage> {
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
        print(
            'Order ${action == 'accept' ? 'accepted' : 'declined'} successfully');
      } else {
        print(
            'Failed to ${action == 'accept' ? 'accept' : 'decline'} order. Status Code: ${response.statusCode}');
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
                                  } else if (order!.isCancelled) {
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    order.serviceType,
                                                    // textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      color: Color(0xFF1C1F34),
                                                      fontSize: 24,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          24.0,
                                                          40.0,
                                                          24.0,
                                                          24.0),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order!.date,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.time,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                            'Customer',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.customerName,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.providerId,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OrderDetailsPage(
                                                                    token: widget
                                                                        .token,
                                                                    providerId:
                                                                        widget
                                                                            .providerId,
                                                                    orderId:
                                                                        order
                                                                            .id,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      900],
                                                            ),
                                                            child: const Text(
                                                              'View Details',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                  } else {
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    order.serviceType,
                                                    // textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      color: Color(0xFF1C1F34),
                                                      fontSize: 24,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          24.0,
                                                          40.0,
                                                          24.0,
                                                          24.0),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order!.date,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.time,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                            'Customer',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.customerName,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        height: 1,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color(
                                                              0xFF3E363F),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                              color: Color(
                                                                  0xFF1C1F34),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            order.providerId,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              acceptOrDeclineOrder(
                                                                  order.id,
                                                                  'accept');
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  // const Color.fromRGBO(166, 135, 255, 1),
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          144,
                                                                          90,
                                                                          219),
                                                            ),
                                                            child: const Text(
                                                              'Accept',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              acceptOrDeclineOrder(
                                                                  order.id,
                                                                  'decline');
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                            child: const Text(
                                                              'Decline',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                        await Future.delayed(
                            Duration(seconds: 1)); // Simulating a delay
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        24.0, 40.0, 24.0, 24.0),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                            color: Color(
                                                                0xFF1C1F34),
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
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
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
                                                            color: Color(
                                                                0xFF1C1F34),
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
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
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
                                                          'Customer',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF1C1F34),
                                                            fontSize: 14,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                          ),
                                                        ),
                                                        Text(
                                                          order.customerName,
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
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF3E363F),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
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
                                                            color: Color(
                                                                0xFF1C1F34),
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        OrderDetailsPage(
                                                                  token: widget
                                                                      .token,
                                                                  providerId: widget
                                                                      .providerId,
                                                                  orderId:
                                                                      order.id,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .green[900],
                                                          ),
                                                          child: const Text(
                                                            'View Details',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                              builder: (context) => providerPage(
                                  token: widget.token,
                                  providerId: widget.providerId)));
                    },
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
                        //             providerId: widget.providerId)));
                      }),
                  const SizedBox(
                      width: 90), // Placeholder for the center button
                  IconButton(
                    icon: Image.asset('lib/assets/images/communicationIcon.png',
                        height: 45, width: 45),
                    onPressed: () {},
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
                      'lib/assets/images/centerIcon.png',
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

class OrderDetailsPage extends StatefulWidget {
  final token;
  final providerId;
  final orderId;
  const OrderDetailsPage({Key? key, this.token, this.providerId, this.orderId})
      : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isLoading = true;
  orderInfo order_info = orderInfo();
  customerInfo customer_info = customerInfo();
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await getOrderById();
    getCustomerDetailsById();
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
          order_info.serviceType = data['order']['serviceType'] ?? '';
          order_info.address = data['order']['address'] ?? '';
          order_info.date = data['order']['date'] ?? '';
          order_info.time = data['order']['time'] ?? '';
          order_info.expectationNote = data['order']['expectationNote'] ?? '';
          order_info.customerId = data['order']['customerId'] ?? '';
          order_info.providerId = data['order']['providerId'] ?? '';
          order_info.isFinished = data['order']['isFinished'] ?? '';
          order_info.isCancelled = data['order']['isCancelled'] ?? '';
          order_info.id = data['order']['id'] ?? '';
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

  Future<void> getCustomerDetailsById() async {
    try {
      final response = await http.get(
        Uri.parse('$customerDetailsbyId${order_info.customerId}'),
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
          isLoading = false;
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

  Future<void> cancelOrderFunc() async {
    try {
      // var cBody = {
      //   'reason': reasonController.text,
      //   'additionalInfo': additionalInfo.text
      // };
      final response = await http.put(
        Uri.parse(
            '$cancelOrderByProvider${widget.orderId}'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
        body: json.encode({'isCancelled': true}),
      );

      if (response.statusCode == 200) {
        print('Order cancelled successfully');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Order cancelled successfully"),
                // content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              // content: Text(err.message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      print('Error cancelling order: $error');
      // throw Exception('Internal Server Error');
    }
  }

  void showCustomCancellationBottomSheet(BuildContext context) {
    TextEditingController _reasonController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6),
                child: Container(
                  width: double.maxFinite,
                  height: 22,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFA686FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(
                        width: 279,
                        child: Text(
                          'Cancel Booking ',
                          style: TextStyle(
                            color: Color(0xFF3E363F),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Warning !',
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                child: SizedBox(
                  // width: 335,
                  child: Text(
                    "Are you sure you want to cancel your requested service? This action cannot be undone. Please confirm to proceed with the cancellation.",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromRGBO(187, 225, 197, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'lib/assets/images/reasonIcon.png',
                            // height: 45, width: 45
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _reasonController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Reason',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              // labelStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Removes the underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    cancelOrderFunc();
                  },
                  child: Container(
                    width: 327,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA686FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel  Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showCustomReschedulingBottomSheet(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    TextEditingController _reasonController = TextEditingController();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    }

    // Function to handle time selection
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }

    Future<void> rescheduleOrderFunc() async {
      try {
        var cBody = {
          'reason': _reasonController.text,
        };
        final response = await http.put(
          Uri.parse(
              '$rescheduleByProvider${widget.orderId}'), // Replace with your API endpoint
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode(order_info),
        );

        if (response.statusCode == 200) {
          print('Order Rescheduled successfully');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Order cancelled successfully"),
                  // content: Text(err.message),
                  actions: [
                    TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        } else {
          throw Exception('Failed to cancel order');
        }
      } catch (error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                // content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        print('Error cancelling order: $error');
        // throw Exception('Internal Server Error');
      }
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6),
                  child: Container(
                    width: double.maxFinite,
                    height: 22,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFA686FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(
                          width: 279,
                          child: Text(
                            'Select your Date & Time?',
                            style: TextStyle(
                              color: Color(0xFF3E363F),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color(0xFFFFE9E9),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            "Select Date of Service: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                        leading: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                      ),
                      ListTile(
                        title: Text(
                            "Select Time of Service: ${selectedTime.format(context)}"),
                        leading: const Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color(0xFFFDFABE),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 0, 6.0, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'lib/assets/images/reasonIcon.png',
                            // height: 45, width: 45
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _reasonController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your Reason',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              // labelStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none, // Removes the underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    order_info.date =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    order_info.time =
                        "${selectedTime.hour}:${selectedTime.minute}";
                    rescheduleOrderFunc();
                  },
                  child: Container(
                    width: 327,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA686FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reschedule  Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!isLoading &&
        !order_info.isCancelled &&
        !order_info.isFinished) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/backIcon.png'),
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
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      // ListTile(
                      //   title: Text('Booking ID'),
                      //   subtitle: Text('#123'),
                      //   trailing: Text('9:41'),
                      // ),
                      ListTile(
                        // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
                        title: Text(order_info.serviceType),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date:   ${order_info.date}'),
                            Text('Time:   ${order_info.time}'),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   title: const Text('Status'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Duration'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // const ListTile(
                      //   title: Text('Price Detail'),
                      //   subtitle: Text('Price: ₹120'),
                      // ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Client',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Card(
                      color: const Color(0xFFFFE9E9),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              customer_info.username,
                              style: const TextStyle(
                                color: Color(0xFF3E363F),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded,
                                        color: Color(0xFF3E363F)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
              InkWell(
                onTap: () {
                  showCustomReschedulingBottomSheet(context);
                },
                child: Container(
                  width: 334,
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFA686FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reschedule Booking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showCustomCancellationBottomSheet(context);
                },
                child: Container(
                  width: 336,
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFA686FF)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel Booking',
                              style: TextStyle(
                                color: Color(0xFFA686FF),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.07,
                              ),
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
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Image(
                image: AssetImage('lib/assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      // ListTile(
                      //   title: Text('Booking ID'),
                      //   subtitle: Text('#123'),
                      //   trailing: Text('9:41'),
                      // ),
                      ListTile(
                        // leading: Image.asset('assets/lawn_treatment.png'), // Replace with your image asset
                        title: Text(order_info.serviceType),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date:   ${order_info.date}'),
                            Text('Time:   ${order_info.time}'),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   title: const Text('Status'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Duration'),
                      //   subtitle: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     color: Colors.purple.shade100,
                      //     child: const Text('Service Time: 35 Min'),
                      //   ),
                      // ),
                      // const ListTile(
                      //   title: Text('Price Detail'),
                      //   subtitle: Text('Price: ₹120'),
                      // ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 27.0, top: 16.0),
                    child: Text(
                      'About Client',
                      style: TextStyle(
                        color: Color(0xFF3E363F),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    child: Card(
                      color: const Color(0xFFFFE9E9),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              customer_info.username,
                              style: const TextStyle(
                                color: Color(0xFF3E363F),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.email_rounded,
                                        color: Color(0xFF3E363F)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.email,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.location_on_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.address,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.call_rounded,
                                        color: Color.fromRGBO(
                                            62, 54, 63, 1)), // Email icon
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      customer_info.mobile_number,
                                      style: const TextStyle(
                                        color: Color(0xFF3E363F),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      );
    }
  }
}

class profilePage extends StatefulWidget {
  final token;
  final providerId;
  const profilePage({required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  void showCustomSignOutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Color(0xFF3E363F),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                child: Text(
                  "Are you sure you want to sign out?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign out logic
                    logoutProvider();
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFA686FF), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Sign out",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFA686FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> logoutProvider() async {
    var url = Uri.parse(providerLogout); // Replace with your actual endpoint
    try {
      print(widget.token);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}', // Include the token in the header
        },
      );

      if (response.statusCode == 200) {
        print('Logout successful');
        await SharedPreferences.getInstance().then((prefs) {
          prefs.remove('token');
          prefs.remove('userOrProvider');
          prefs.remove('id');
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'AP Landscaping',
                  )),
          (Route<dynamic> route) => false,
        );
        // Handle successful logout
      } else {
        print(response.statusCode);
        // print(response['error']);
        print(json.decode(response.body)['error']);
        print('Failed to logout');
        // Handle error response
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle any exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: const Text(
          'More',
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
        // backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: const Color(0xFFBBE1C5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF3E363F),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/userIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'My Account',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => updateprofileInfoPage(
                                      token: widget.token,
                                      providerId: widget.providerId)));
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF96C257),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/settingsIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFC8B88A),
                            shape: OvalBorder(),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/assets/images/logoutIcon.png',
                              // height: 100, // Adjust the size of the inner image/icon
                              // width: 100,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        title: const Text(
                          'Sign out',
                          style: TextStyle(
                            color: Color(0xFF181D27),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // logoutprovider();
                          //  Navigator.of(context).pushReplacementNamed('/home');
                          // print(widget.token);
                          showCustomSignOutBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => providerPage(
                                token: widget.token,
                                providerId: widget.providerId)));
                  },
                  // onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                    icon: Image.asset('lib/assets/images/myServicesIcon.png',
                        height: 45, width: 45),
                    onPressed: () {
                      // _onItemTapped(1);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myServicesPage(
                                  token: widget.token,
                                  providerId: widget.providerId)));
                    }),
                const SizedBox(width: 90), // Placeholder for the center button
                IconButton(
                  icon: Image.asset('lib/assets/images/communicationIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
                  // onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/images/morePressedIcon.png',
                      height: 45, width: 45),
                  onPressed: () {},
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
    );
  }
}

class updateprofileInfoPage extends StatefulWidget {
  final token;
  final providerId;
  const updateprofileInfoPage(
      {required this.token, required this.providerId, Key? key})
      : super(key: key);

  @override
  State<updateprofileInfoPage> createState() => _updateprofileInfoPageState();
}

class _updateprofileInfoPageState extends State<updateprofileInfoPage> {
  providerInfo provider_info = providerInfo();
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '');
    _mobileNumberController = TextEditingController(text: '');
    fetchProviderInfo().then((fetchedProviderInfo) {
      _usernameController.text = fetchedProviderInfo.username ?? '';
      _emailController.text = fetchedProviderInfo.email ?? '';
      _addressController.text = fetchedProviderInfo.address ?? '';
      _mobileNumberController.text = fetchedProviderInfo.mobile_number ?? '';
      setState(() {
        provider_info = fetchedProviderInfo;
        isLoading = false;
      });
    });
  }

  Future<providerInfo> fetchProviderInfo() async {
    providerInfo provider_info1 = providerInfo();
    final url = Uri.parse(providerProfileInfo); // Replace with your API URL
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          provider_info1.username = data['provider']['username'] ?? '';
          provider_info1.email = data['provider']['email'] ?? '';
          provider_info1.mobile_number = data['provider']['mobilenumber'] ?? '';
          provider_info1.password = data['provider']['password'] ?? '';
          provider_info1.address = data['provider']['address'] ?? '';
          provider_info1.card_details = data['provider']['carddetails'] ?? '';
          provider_info1.cvv = data['provider']['cvv'] ?? '';
          provider_info1.paypal_id = data['provider']['paypalid'] ?? '';
          provider_info1.aec_transfer = data['provider']['aectransfer'] ?? '';
          provider_info1.card_type = data['provider']['cardtype'] ?? '';
          provider_info1.card_holders_name =
              data['provider']['cardholdersname'] ?? '';
          provider_info1.card_number = data['provider']['cardnumber'] ?? '';
          isLoading = false;
        });
        return provider_info1;
      } else {
        // Handle error or non-200 responses
        print('Failed to fetch provider info');
        return provider_info1;
      }
    } catch (e) {
      print('Error: $e');
      return provider_info1;
    }
  }

  Future<void> updateProviderInfo() async {
    final url = Uri.parse(providerProfileInfo);
    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '${widget.token}',
          },
          body: json.encode({
            'username': provider_info.username,
            'email': provider_info.email,
            'mobilenumber': provider_info.mobile_number,
            'address': provider_info.address,
            'carddetails': provider_info.card_details,
            'cvv': provider_info.cvv,
            'paypalid': provider_info.paypal_id,
            'aectransfer': provider_info.aec_transfer,
            'cardtype': provider_info.card_type,
            'cardholdersname': provider_info.card_holders_name,
            'cardnumber': provider_info.card_number,
          }));
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        setState(() {
          provider_info.username = data['updatedProvider']['username'] ?? '';
          provider_info.email = data['updatedProvider']['email'] ?? '';
          provider_info.mobile_number =
              data['updatedProvider']['mobilenumber'] ?? '';
          provider_info.address = data['updatedProvider']['address'] ?? '';
          provider_info.card_details =
              data['updatedProvider']['carddetails'] ?? '';
          provider_info.cvv = data['updatedProvider']['cvv'] ?? '';
          provider_info.paypal_id = data['updatedProvider']['paypalid'] ?? '';
          provider_info.aec_transfer =
              data['updatedProvider']['aectransfer'] ?? '';
          provider_info.card_type = data['updatedProvider']['cardtype'] ?? '';
          provider_info.card_number =
              data['updatedProvider']['cardnumber'] ?? '';
        });
        print('Provider profile updated successfully');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Profile Successfully Updated"),
                // content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        print('Failed to update provider profile');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                // content: Text(err.message),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'My Account',
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
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                    child: TextFormField(
                      controller: _mobileNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                      // onSaved: (value) =>
                      //     widget.provider_info.address = value ?? '',
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please enter an address' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          provider_info.username = _usernameController.text;
                          provider_info.email = _emailController.text;
                          provider_info.address = _addressController.text;
                          provider_info.mobile_number =
                              _mobileNumberController.text;
                        });
                        updateProviderInfo();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        // backgroundColor: Colors.blue,
                        backgroundColor: const Color(0xFFA686FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ), // Calling the update function
                      child: const Text('Update Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
