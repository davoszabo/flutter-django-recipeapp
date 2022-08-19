import 'package:flutter/foundation.dart';

class Filter {
  final String category;
  final String name;
  bool selected = false;

  Filter({@required this.category, @required this.name});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      category: json['category'],
      name: json['name'],
    );
  }
}
