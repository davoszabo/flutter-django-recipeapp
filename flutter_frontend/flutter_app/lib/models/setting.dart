import 'package:flutter/foundation.dart';

class Setting {
  final String id;
  final String display_name;
  int value;

  Setting(
      {@required this.id, @required this.display_name, @required this.value});

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json['id'],
      display_name: json['display_name'],
      value: json['value'].parse(int),
    );
  }
}
