import 'dart:core';

class orderInfo {
  String serviceType;
  String address;
  String date;
  String time;
  String expectationNote;
  String customerId;
  String? providerId;
  bool isFinished = false;
  bool isCancelled = false;
  bool isRescheduled = false;
  String id;
  String customerName;
  String? providerName;
  bool isAcceptedByProvider;
  String orderId;

  orderInfo(
      {this.serviceType = '',
      this.address = '',
      this.date = '',
      this.time = '',
      this.expectationNote = '',
      this.customerId = '',
      this.providerId = '',
      this.isFinished = false,
      this.isCancelled = false,
      this.isRescheduled = false,
      this.id = '',
      this.orderId = '',
      this.customerName = '',
      this.providerName,
      this.isAcceptedByProvider = false});

  Map<String, dynamic> toJson() => {
    'serviceType': serviceType,
    'address': address,
    'time': time,
    'expectationNote': expectationNote,
    'customerId': customerId,
    'providerId': providerId,
    'isFinished': isFinished,
    'isCancelled': isCancelled,
    'isRescheduled': isRescheduled,
    'id': id,
    'orderId': orderId,
    'customerName': customerName,
    'providerName': providerName,
    'isAcceptedByProvider': isAcceptedByProvider,
    'date': date,
  };
}
