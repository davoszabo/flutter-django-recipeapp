import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../global/globals.dart';

class Recommendations with ChangeNotifier {
  List<Recipe> _recitems = [];

  final String token;
  final int userId;

  Recommendations(this.token, this.userId, this._recitems);

  List<Recipe> get recitems {
    return [..._recitems];
  }

  final url = Globals.url;

  Future<void> fetchRecData(String recSys) async {
    print(recSys);
    final finalUrl =
        Uri.parse('$url/api/recommendations/?format=json&recSys=$recSys');
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

      _recitems =
          jsonResponse.map((data) => new Recipe.fromJson(data)).toList();

      _recitems.forEach((element) => print(element.id));

      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Recipe findById(int id) {
    return _recitems.firstWhere((recipe) => recipe.id == id);
  }
}
