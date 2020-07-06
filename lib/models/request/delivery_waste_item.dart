import 'package:flutter/material.dart';

import '../status.dart';
import 'collect.dart';
import 'collect_status.dart';
import 'collect_time.dart';
import 'pasmand.dart';

class DeliveryWasteItem with ChangeNotifier {
  final int id;
  final Status status;
  final CollectStatus total_collects_price;
  final CollectStatus total_collects_weight;
  final CollectStatus total_collects_number;

  final Pasmand store;
  final Pasmand driver;
  final Pasmand operator;

  final CollectTime collect_date;
  final List<Collect> collect_list;

  DeliveryWasteItem({
    this.id,
    this.status,
    this.total_collects_price,
    this.total_collects_weight,
    this.total_collects_number,
    this.store,
    this.driver,
    this.operator,
    this.collect_date,
    this.collect_list,
  });

  factory DeliveryWasteItem.fromJson(Map<String, dynamic> parsedJson) {
    List<Collect> collectRaw = [];
    if (parsedJson['collect_list'] != null) {
      var collectList = parsedJson['collect_list'] as List;
      collectRaw = collectList.map((i) => Collect.fromJson(i)).toList();
    }
    return DeliveryWasteItem(
      id: parsedJson['id'],
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
      store: parsedJson['store'] != null
          ? Pasmand.fromJson(parsedJson['store'])
          : Pasmand(id: 0, post_title: ''),
      driver: parsedJson['driver'] != null
          ? Pasmand.fromJson(parsedJson['driver'])
          : Pasmand(id: 0, post_title: ''),
      operator: parsedJson['operator'] != null
          ? Pasmand.fromJson(parsedJson['operator'])
          : Pasmand(id: 0, post_title: ''),
      collect_date: parsedJson['collect_date'] != null
          ? CollectTime.fromJson(parsedJson['collect_date'])
          : CollectTime(time: '0', day: '0', collect_done_time: '0'),
      collect_list: collectRaw,
    );
  }

  Map<String, dynamic> toJson() {
    Map status = this.status != null ? this.status.toJson() : null;
    Map driver = this.driver != null ? this.driver.toJson() : null;
    Map total_price = this.total_collects_price != null
        ? this.total_collects_price.toJson()
        : null;
    Map total_weight = this.total_collects_weight != null
        ? this.total_collects_weight.toJson()
        : null;
    Map total_number = this.total_collects_number != null
        ? this.total_collects_number.toJson()
        : null;
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
      'collect_list': collect_list,
      'driver': driver,
    };
  }
}
