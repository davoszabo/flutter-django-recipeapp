import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../global/globals.dart';

class Favorites with ChangeNotifier {
  List<Recipe> _favitems = [];

  final String token;
  final int userId;

  Favorites(this.token, this.userId, this._favitems);

  List<Recipe> get favitems {
    return [..._favitems];
  }

  final url = Globals.url;

  Future<void> fetchFavData() async {
    final finalUrl = Uri.parse('$url/api/favorites/?format=json');
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');
    // print(url);
    final response = await http.get(finalUrl, headers: {
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    // print(response.body);
    // await http.get('https://jsonplaceholder.typicode.com/albums');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      // print(jsonResponse.length);

      _favitems =
          jsonResponse.map((data) => new Recipe.fromJson(data)).toList();

      _favitems.forEach((element) => print(element.id));

      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<int>> fetchFavIds() async {
    final finalUrl = Uri.parse('$url/api/favorites/?format=json');
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');
    // print(url);
    final response = await http.get(finalUrl, headers: {
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    // print(response.body);
    // await http.get('https://jsonplaceholder.typicode.com/albums');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      // print(jsonResponse.length);

      List ids = jsonResponse.map((data) => data["id"] as int).toList();

      return ids;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> toggleFav(int id) async {
    final finalUrl = Uri.parse('$url/api/togglefav/$id');
    // final url = Uri.parse('http://10.0.2.2:8000/api/recipes/?format=json');

    final response = await http.get(finalUrl, headers: {
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    print(response.statusCode);
    // await http.get('https://jsonplaceholder.typicode.com/albums');
    print(response.statusCode);
    if (response.statusCode == 200) {
      fetchFavData();
      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Recipe findById(int id) {
    return _favitems.firstWhere((recipe) => recipe.id == id);
  }
}
