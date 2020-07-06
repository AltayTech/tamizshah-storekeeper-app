import 'package:flutter/foundation.dart';
import 'package:tamizshahr_storekeeper/models/operator_data.dart';

import 'status.dart';

class Operator with ChangeNotifier {
  final int id;
  final Status status;
  final List<Status> type;
  final OperatorData operatorData;

  Operator({
    this.id,
    this.status,
    this.type,
    this.operatorData,
  });

  factory Operator.fromJson(Map<String, dynamic> parsedJson) {
    var typesList = parsedJson['type'] as List;
    List<Status> typesRaw = new List<Status>();

    typesRaw = typesList.map((i) => Status.fromJson(i)).toList();
    return Operator(
      id: parsedJson['id'] != null ? parsedJson['id'] : 0,
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '', slug: ''),
      type: typesRaw,
      operatorData: OperatorData.fromJson(parsedJson['operator_data']),
    );
  }

  Map<String, dynamic> toJson() {
    Map operatorData =
        this.operatorData != null ? this.operatorData.toJson() : null;

    return {
      'operator_data': operatorData,
      'type': type,
      'id': id,
    };
  }
}
