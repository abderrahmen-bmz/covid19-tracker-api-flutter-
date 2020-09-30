import 'package:flutter/cupertino.dart';

class EndpointData {
  EndpointData({
    @required this.value,
    @required this.date,
  }) : assert(value != null);

  final int value;
  final DateTime date;

  @override
  String toString() => 'date:$date, value:$value';
}
