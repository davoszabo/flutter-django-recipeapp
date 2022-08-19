import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/cuisine.dart';

class Cuisines with ChangeNotifier {
  List<Cuisine> _items = [];

  // final String authToken;
  // final String userId;

  // Products(this.authToken, this.userId, this._items);

  List<Cuisine> get items {
    return [..._items];
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/cuisines/?format=json'));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _items = jsonResponse.map((data) => new Cuisine.fromJson(data)).toList();
      print(_items.first.name);
      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Cuisine findById(int id) {
    return _items.firstWhere((recipe) => recipe.id == id);
  }
}
