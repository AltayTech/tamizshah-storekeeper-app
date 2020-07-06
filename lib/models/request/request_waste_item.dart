import 'package:flutter/material.dart';


import '../driver.dart';
import '../status.dart';
import 'address.dart';
import 'collect.dart';
import 'collect_status.dart';
import 'collect_time.dart';

class RequestWasteItem with ChangeNotifier {
  final int id;
  final Status status;
  final Status collect_type;
  final CollectStatus total_collects_price;
  final CollectStatus total_collects_weight;
  final CollectStatus total_collects_number;
  final CollectTime collect_date;
  final Address address_data;
  final List<Collect> collect_list;
  final Driver driver;

  RequestWasteItem(
      {this.id,
      this.status,
      this.collect_type,
      this.total_collects_price,
      this.total_collects_weight,
      this.total_collects_number,
      this.collect_date,
      this.address_data,
      this.collect_list,
      this.driver});

  factory RequestWasteItem.fromJson(Map<String, dynamic> parsedJson) {
    var collectList = parsedJson['collect_list'] as List;
    List<Collect> collectRaw =
        collectList.map((i) => Collect.fromJson(i)).toList();

    return RequestWasteItem(
      id: parsedJson['id'],
      collect_type: parsedJson['collect_type'] != null
          ? Status.fromJson(parsedJson['collect_type'])
          : Status(term_id: 0, name: '0', slug: '0'),
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '0', slug: '0'),
      total_collects_price: parsedJson['total_collects_price'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_price'])
          : CollectStatus(estimated: '0', exact: '0'),
      total_collects_weight: parsedJson['total_collects_weight'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_weight'])
          : CollectStatus(estimated: '0', exact: '0'),
      total_collects_number: parsedJson['total_collects_number'] != null
          ? CollectStatus.fromJson(parsedJson['total_collects_number'])
          : CollectStatus(estimated: '0', exact: '0'),
      collect_date: parsedJson['collect_date'] != null
          ? CollectTime.fromJson(parsedJson['collect_date'])
          : CollectTime(time: '0', day: '0', collect_done_time: '0'),
      address_data: Address.fromJson(parsedJson['address_data']),
      collect_list: collectRaw,
      driver: Driver.fromJson(parsedJson['driver']),
    );
  }

  Map<String, dynamic> toJson() {
    Map address = this.address_data != null ? this.address_data.toJson() : null;
    Map status = this.status != null ? this.status.toJson() : null;
    Map driver = this.driver != null ? this.driver.toJson() : null;
    Map total_price =
        this.total_collects_price != null ? this.total_collects_price.toJson() : null;
    Map total_weight =
        this.total_collects_weight != null ? this.total_collects_weight.toJson() : null;
    Map total_number =
        this.total_collects_number != null ? this.total_collects_number.toJson() : null;
    Map collect_time =
        this.collect_date != null ? this.collect_date.toJson() : null;

    List<Map> collect_list = this.collect_list != null
        ? this.collect_list.map((i) => i.toJson()).toList()
        : null;

    return {
      'id': id,
      'status': status,
      'total_price': total_price,
      'total_weight': total_weight,
      'total_number': total_number,
      'collect_time': collect_time,
      'address_data': address,
      'collect_list': collect_list,
      'driver': driver,
    };
  }
}
