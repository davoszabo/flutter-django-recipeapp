import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/recipes.dart';
import '../providers/filters.dart';

class SearchScreen extends StatefulWidget {
  static const route = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController = TextEditingController();

  void searchSubmit() {
    Provider.of<Recipes>(context, listen: false).fetchData(
        Provider.of<Filters>(context, listen: false)
            .items
            .where((e) => e.selected)
            .map((e) => e.name)
            .toList(),
        _searchTextController.text);
    print(_searchTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _searchTextController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchTextController.clear();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onSubmitted: (value) {
                searchSubmit();
                _searchTextController.clear();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
