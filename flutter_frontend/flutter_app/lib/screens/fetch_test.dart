import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './recipe_details_screen.dart';

class Data {
  final int userId;
  final int id;
  final String title;

  Data({this.userId, this.id, this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Datas with ChangeNotifier {
  List<Data> _items = [];

  List<Data> get items => [..._items];

  Future<void> fetchData() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _items = jsonResponse.map((data) => new Data.fromJson(data)).toList();
      // print(_items);
      notifyListeners();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Data findById(int id) {
    return _items.firstWhere((recipe) => recipe.id == id);
  }
}

class FetchTestScreen extends StatefulWidget {
  FetchTestScreen({Key key}) : super(key: key);

  @override
  FetchTestScreenState createState() => FetchTestScreenState();
}

class FetchTestScreenState extends State<FetchTestScreen> {
  Future futureData;

  Future obtainFutureData() {
    return Provider.of<Datas>(context, listen: false).fetchData();
  }

  @override
  void initState() {
    futureData = obtainFutureData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ASD");
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done) {
              // List<Data> data = snapshot.data;
              return Consumer<Datas>(
                builder: (ctx, data, child) => ListView.builder(
                  itemCount: data._items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RecipeDetailsScreen.route,
                          arguments: data._items[index].id,
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            "${data._items[index].title}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              // By default show a loading spinner.
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
