import 'package:ap_landscaping/pages/customer/customer_order_details.dart';
import 'package:ap_landscaping/utilities/helper_functions.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config.dart';
import '../../models/orderinfo.dart';

class CustomerCalendarPage extends StatefulWidget {
  final String token;
  final String customerId;

  const CustomerCalendarPage({required this.token, required this.customerId, Key? key})
      : super(key: key);

  @override
  _CustomerCalendarPageState createState() => _CustomerCalendarPageState();
}

class _CustomerCalendarPageState extends State<CustomerCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _focusedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Map<DateTime, List<Map<String, String?>>> _events = {};
  bool isLoaded = false;

  late Future<List<orderInfo>> orders;

  @override
  void initState() {
    super.initState();
    orders = fetchOrders();
  }

  Future<List<orderInfo>> fetchOrders() async {
    final response = await http.get(
      Uri.parse(customerUpcomingOrders),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.token,
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson = json.decode(response.body)['upcomingOrders'];
      print(ordersJson);
      final List<orderInfo> orders = [];
      for (var order in ordersJson) {
        orders.add(orderInfo(
          serviceType: order['serviceType'],
          address: order['address'],
          date: order['date'],
          time: order['time'],
          expectationNote: order['expectationNote'].toString(),
          customerId: order['customerId'],
          providerId: order['providerId'] ?? "NA",
          isFinished: order['isFinished'],
          isCancelled: order['isCancelled'],
          id: order['id'],
          providerName: order['providerName'] ?? "Not Assigned yet!",
        ));
      }
      // for (var order in orders) {
        // print("Order ID: ${order.id}");
        // print("Service Type: ${order.serviceType}");
        // print("Address: ${order.address}");
        // print("Date: ${order.date}");
        // print("Time: ${order.time}");
        // print("Expectation Note: ${order.expectationNote}");
        // print("Customer ID: ${order.customerId}");
        // print("Provider ID: ${order.providerId}");
        // print("Is Finished: ${order.isFinished}");
        // print("Is Cancelled: ${order.isCancelled}");
        // print("Provider Name: ${order.providerName}");
        // Print other details as needed
        // print("-----------------------------------");
      // }
      _updateEvents(orders);
      setState(() {
        isLoaded = true;
      });
      return orders;

    } else {
      throw Exception('Failed to load customer orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Calendar',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Image(
            image: AssetImage('assets/images/backIcon.png'),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoaded
          ? Column(
            children: [
              Center(
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      // print("Selected Day - $_selectedDay");
                      // print("Focused Day - $_focusedDay");
                    });
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      // print("Selected Day - $selectedDay");
                      // print("Focused Day - $focusedDay");
                    });
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(_selectedDay, date);
                  },
                  calendarStyle: const CalendarStyle(
                    markersAlignment: Alignment.bottomLeft,
                    defaultTextStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  daysOfWeekVisible: true,
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, date, _) {
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.green.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context, date, _) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(8, 7, 8, 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        List<Widget> markers = [];
                        int numDots = events.length <= 5 ? events.length : 5;
                        for (int i = 0; i < numDots; i++) {
                          markers.add(
                            Container(
                              width: 6,
                              height: 6,
                              margin: EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                          );
                        }

                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: markers,
                          ),
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ListView(
                    children: _buildEventsList(_selectedDay),
                  ),
                ),
              ),
            ],
          )
          : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Loading Calendar Please wait',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
    );
  }



  List<Widget> _buildEventsList(DateTime selectedDay) {
    final events = _events[selectedDay];
    return events != null
      ? events.map((event) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: GestureDetector(
          onTap: () {
            // Navigate to another page when tapped
            print(event['provider']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerOrderDetailsPage(
                  customerId: widget.customerId,
                  token: widget.token,
                  orderId: event['orderId'],
                )
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade700.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 8, // Width of the icon
                        height: 8, // Height of the icon
                        margin: EdgeInsets.only(right: 5, top: 5), // Adjust spacing as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2), // Border properties
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          'Time: ${event['time']}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: Text(
                    '${event['title']}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: fontHelper(context) * 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                  child: Text(
                    event['provider'] != "NA" ? 'Provider Assigned!! Click to see details!!' : 'Not Assigned Yet!!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: fontHelper(context) * 12,
                      color: Colors.grey.shade700,
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      )).toList()
        : [
      const Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
            child: Text('No events for this day')
        ),
      )
    ];
  }


  List<String> _getEventsForDay(DateTime day) {
    final events = _events[day];
    return events != null ? events.map((e) => e['title']!).toList() : [];
  }

  void _updateEvents(List<orderInfo> orders) {
    print("updating events!!");
    _events.clear(); // Clear existing events
    for (var order in orders) {
      final orderDate = DateTime.parse(order.date);
      final formattedDate = DateTime.utc(orderDate.year, orderDate.month, orderDate.day);
      final eventMap = {
        'title': order.serviceType,
        'time': order.time,
        'provider': order.providerId!,
        'orderId': order.id,
      };
      if (_events.containsKey(formattedDate)) {
        _events[formattedDate]!.add(eventMap);
      } else {
        _events[formattedDate] = [eventMap];
      }
    }
  }

  @override
  void didUpdateWidget(covariant CustomerCalendarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    orders = fetchOrders();
    orders.then((value) => _updateEvents(value));
  }
}
