import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/filter.dart';

import '../providers/filters.dart';

class FilterScreen extends StatefulWidget {
  static const route = "/filter";

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget buildSection(String text, var originalFilters) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   color: Colors.black54,
          //   borderRadius: BorderRadius.circular(5),
          // ),
          padding: EdgeInsets.only(top: 15),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 5,
              direction: Axis.horizontal,
              children: techChips(originalFilters.items
                  .where((element) => element.category == text.toLowerCase())
                  .toList()),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> techChips(filters) {
    List<Widget> chips = [];
    for (int i = 0; i < filters.length; i++) {
      Widget item = FilterChip(
        label: Text(filters[i].name),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.grey,
        selectedColor: Colors.red,
        selected: filters[i].selected,
        onSelected: (bool value) {
          setState(() {
            filters[i].selected = value;
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<Filters>(context)
    //     .items
    //     .where((e) => e.selected)
    //     .map((e) => e.name)
    //     .toList()
    //     .isEmpty);
    final originalFilters = Provider.of<Filters>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSection("Meal-time", originalFilters),
              buildSection("Health", originalFilters),
              buildSection("Allergenic", originalFilters),
              buildSection("Ingredient", originalFilters),
              buildSection("Cuisine", originalFilters),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     final selectedFilters =
      //         originalFilters.items.where((element) => element.selected);
      //     final tags = selectedFilters.map((e) => e.name).toList();
      //     print(tags);
      //   },
      //   label: Text(
      //     "Submit",
      //     style: TextStyle(
      //       fontSize: 26,
      //       color: Colors.white,
      //       // fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   backgroundColor: Colors.red,
      //   elevation: 10,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
