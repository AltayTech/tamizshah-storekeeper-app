import 'package:flutter/material.dart';
import '../models/status.dart';

import '../models/driver_data.dart';
import 'request/pasmand.dart';

class Driver with ChangeNotifier {
  final Status status;
  final Status car;
  final Status car_color;
  final String car_number;
  final DriverData driver_data;
  final List<Pasmand> stores;
  final String money;

  Driver({
    this.status,
    this.car,
    this.car_color,
    this.car_number,
    this.driver_data,
    this.stores,
    this.money,
  });

  factory Driver.fromJson(Map<String, dynamic> parsedJson) {
    var storeList = parsedJson['stores'] as List;
    List<Pasmand> storeRaw = new List<Pasmand>();

    storeRaw =
        storeList.map((i) => Pasmand.fromJson(i)).toList();

    return Driver(
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '', slug: ''),
      car: parsedJson['car'] != null
          ? Status.fromJson(parsedJson['car'])
          : Status(term_id: 0, name: '', slug: ''),
      car_color: parsedJson['car_color'] != null
          ? Status.fromJson(parsedJson['car_color'])
          : Status(term_id: 0, name: '', slug: ''),
      car_number:
          parsedJson['car_number'] != null ? parsedJson['car_number'] : '',
      driver_data: DriverData.fromJson(parsedJson['driver_data']),
      stores:storeRaw,
      money: parsedJson['money'] != null ? parsedJson['money'] : '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'car': car,
      'car_color': car_color,
      'driver_data': driver_data,
    };
  }
}
