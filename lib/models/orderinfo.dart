import 'dart:core';

class orderInfo {
  String serviceType;
  String address;
  String date;
  String time;
  String expectationNote;
  String customerId;
  String providerId;
  bool isFinished = false;
  bool isCancelled = false;
  String id;
  String customerName;
  String? providerName;
  bool isAcceptedByProvider;

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
      this.id = '',
      this.customerName = '',
      this.providerName,
      this.isAcceptedByProvider = false});

  Map<String, dynamic> toJson() => {
        'serviceType': serviceType,
        'address': address,
        'date': date,
        'time': time,
        'expectationNote': expectationNote,
        'customerId': customerId,
        'providerId': providerId,
        'isFinished': isFinished,
        'isCancelled': isCancelled,
        'id': id,
        'customerName': customerName,
        'providerName': providerName,
        'isAcceptedByProvider': isAcceptedByProvider,
      };
}
