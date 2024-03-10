import 'dart:core';

class providerInfo {
  String username;
  String email;
  String mobile_number;
  String password;
  String address;
  String card_details;
  int cvv;
  String paypal_id;
  String aec_transfer;
  String card_type;
  String card_holders_name;
  String card_number;
  String qualifications;
  int years_of_experience;
  String bio;
  String bank_name;
  String account_nummber;
  List<String> services;
  String google_id;

  providerInfo({
    this.username = '',
    this.email = '',
    this.mobile_number = '',
    this.password = '',
    this.address = '',
    this.card_details = '',
    this.cvv = 0,
    this.paypal_id = '',
    this.aec_transfer = '',
    this.card_type = '',
    this.card_holders_name = '',
    this.card_number = '',
    this.qualifications = '',
    this.years_of_experience = 0,
    this.bio = '',
    this.bank_name = '',
    this.google_id = '',
    this.account_nummber = '',
    List<String>? services,
  }) : services = services ?? [];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'mobile_numder': mobile_number,
        'password': password,
        'address': address,
        'card_details': card_details,
        'cvv': cvv,
        'paypal_id': paypal_id,
        'aec_transfer': aec_transfer,
        'card_type': card_type,
        'card_holders_name': card_holders_name,
        'card_number': card_number,
        'qualifications': qualifications,
        'years_of_experience': years_of_experience,
        'bio': bio,
        'bankname': bank_name,
        'account_number': account_nummber,
        'services': services,
        'google_id': google_id
      };
}
