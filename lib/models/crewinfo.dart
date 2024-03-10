import 'dart:core';

class crewInfo {
  String fullname;
  String username;
  String email;
  String mobilenumber;
  String city;
  String expertise;
  String id;

  crewInfo(
      {this.fullname = '',
      this.username = '',
      this.email = '',
      this.mobilenumber = '',
      this.city = '',
      this.expertise = '',
      this.id = ''});

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'username': username,
        'email': email,
        'mobilenumber': mobilenumber,
        'city': city,
        'expertise': expertise,
        'id': id,
      };
}
