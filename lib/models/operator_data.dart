import 'package:flutter/foundation.dart';

class OperatorData with ChangeNotifier {
  final String fname;
  final String lname;
  final String ostan;
  final String city;
  final String phone;
  final String mobile;
  final String address;
  final String postcode;
  final String email;

  OperatorData({
    this.phone,
    this.fname,
    this.lname,
    this.email,
    this.ostan,
    this.city,
    this.mobile,
    this.address,
    this.postcode,
  });

  factory OperatorData.fromJson(Map<String, dynamic> parsedJson) {
    return OperatorData(

      phone: parsedJson['phone'] != null ? parsedJson['phone'] : '',
      fname: parsedJson['fname'] != null ? parsedJson['fname'] : '',
      lname: parsedJson['lname'] != null ? parsedJson['lname'] : '',
      email: parsedJson['email'] != null ? parsedJson['email'] : '',
      ostan: parsedJson['ostan'] != null ? parsedJson['ostan'] : '',
      city: parsedJson['city'] != null ? parsedJson['city'] : '',
      mobile: parsedJson['mobile'] != null ? parsedJson['mobile'] : '',
      address: parsedJson['address'] != null ? parsedJson['address'] : '',
      postcode: parsedJson['postcode'] != null ? parsedJson['postcode'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'fname': fname,
      'lname': lname,
      'email': email,
      'ostan': ostan,
      'city': city,
      'address_data': address,
      'postcode': postcode,
    };
  }
}
