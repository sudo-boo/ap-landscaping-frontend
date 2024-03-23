import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/customerinfo.dart';
import '../../models/orderinfo.dart';


class ProviderOrderDetailsPage extends StatefulWidget {
  final token;
  final providerId;
  final orderId;
  const ProviderOrderDetailsPage({Key? key, this.token, this.providerId, this.orderId})
      : super(key: key);

  @override
  _ProviderOrderDetailsPageState createState() => _ProviderOrderDetailsPageState();
}

class _ProviderOrderDetailsPageState extends State<ProviderOrderDetailsPage> {
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
