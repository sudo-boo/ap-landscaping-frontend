import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/orderinfo.dart';
import 'package:intl/intl.dart';
import 'customer_billing_page.dart';

class CustomerSchedulingPage extends StatefulWidget {
  final token;
  final customerId;
  final String serviceName;

  const CustomerSchedulingPage(
      {Key? key, required this.serviceName, this.token, this.customerId})
      : super(key: key);

  @override
  _CustomerSchedulingPageState createState() => _CustomerSchedulingPageState();
}

class _CustomerSchedulingPageState extends State<CustomerSchedulingPage> {
  orderInfo order_info = orderInfo();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController expectationsController = TextEditingController();
  TextEditingController addressController =
  TextEditingController(text: 'Default Address of the user');

  // Function to handle date selection
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // title: Text(widget.serviceName),
        title: const Text(
          'Book Services',
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
              Navigator.pop(context);
            }),
        // backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 217,
                  height: 69,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 53,
                        child: Text(
                          'Step1',
                          style: TextStyle(
                            color: Color(0xFF3E363F),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 172,
                        top: 53,
                        child: Text(
                          'Step 2',
                          style: TextStyle(
                            color: Color(0xFF3E363F),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1,
                        top: 0,
                        child: SizedBox(
                          width: 212,
                          height: 37,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 37,
                                  height: 37,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 37,
                                          height: 37,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFA686FF),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Text(
                                          '01',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 18.50,
                                child: Container(
                                  width: 100,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1.50,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF3E363F),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 175,
                                top: 0,
                                child: SizedBox(
                                  width: 37,
                                  height: 37,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 37,
                                          height: 37,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF3E363F)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 10,
                                        top: 10,
                                        child: Text(
                                          '02',
                                          style: TextStyle(
                                            color: Color(0xFF3E363F),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Card(
                color: const Color(0xFFCEF29B),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        child: ListTile(
                          // tileColor: Colors.white,
                          title: Text(
                              "Select Date of Service: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                          leading: const Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        child: ListTile(
                          title: Text(
                              "Select Time of Service: ${selectedTime.format(context)}"),
                          leading: const Icon(Icons.access_time),
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        child: TextField(
                          controller: addressController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Edit Address',
                            hintText: 'Enter your address',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            // border: OutlineInputBorder(),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the border radius as needed
                  ),
                  child: TextField(
                    controller: expectationsController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Expectation Note",
                      hintText: "Describe your expectations",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // const Spacer(),
              InkWell(
                onTap: () {
                  order_info.serviceType = widget.serviceName;
                  order_info.date = DateFormat('yyyy-MM-dd').format(selectedDate);
                  order_info.time = "${selectedTime.hour}:${selectedTime.minute}";
                  order_info.address = addressController.text;
                  order_info.expectationNote = expectationsController.text;
                  order_info.customerId = widget.customerId;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerBillingPage(
                            token: widget.token,
                            customerId: widget.customerId,
                            order_info: order_info,
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFA686FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                // height: 0,
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    expectationsController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
