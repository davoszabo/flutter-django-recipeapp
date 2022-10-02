import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../global/globals.dart';

class Recipes with ChangeNotifier {
  List<Recipe> _items = [];

  // final String authToken;
  // final String userId;

  // Products(this.authToken, this.userId, this._items);

  List<Recipe> get items {
    return [..._items];
  }

  final url = Globals.url;

  Future<void> fetchData(List<String> tags, String search) async {
    final baseUrl = "$url/api/recipes/?format=json";
    final tagQuery = (tags.isNotEmpty) ? "&tags=${tags.join('+')}" : "";
    final searchQuery =
        (search.isNotEmpty) ? "&search=${search.replaceAll(' ', '+')}" : "";
    final finalUrl = Uri.parse(baseUrl + tagQuery + searchQuery);
    print(finalUrl);
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');
    // print(url);
    final response =
        await http.get(finalUrl, headers: {"Accept": "application/json"});

    // print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // jsonResponse.forEach((element) => print(element['name']));

      _items = jsonResponse.map((data) => new Recipe.fromJson(data)).toList();

      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> searchFetchData(String searchQuery) async {
    final finalUrl =
        Uri.parse('$url/api/recipes/?format=json&search=$searchQuery');
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');
    // print(url);
    final response =
        await http.get(finalUrl, headers: {"Accept": "application/json"});

    // print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // jsonResponse.forEach((element) => print(element['name']));

      _items = jsonResponse.map((data) => new Recipe.fromJson(data)).toList();

      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Recipe> fetchById(int id) async {
    final finalUrl = Uri.parse('$url/api/recipes/$id/?format=json');
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');

    final response =
        await http.get(finalUrl, headers: {"Accept": "application/json"});
    // print(response.body);
    // await http.get('https://jsonplaceholder.typicode.com/albums');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      // print(jsonResponse.length);
      // print(jsonResponse['id']);

      Recipe recipe = Recipe.fromJson(jsonResponse);
      // notifyListeners();
      return recipe;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Recipe findById(int id) {
    return _items.firstWhere((recipe) => recipe.id == id);
  }
}
