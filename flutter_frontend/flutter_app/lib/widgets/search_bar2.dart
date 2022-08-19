import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../screens/filter_screen.dart';

import '../common/theme.dart';

class SearchBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Search Box
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              },
              child: Ink(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: appTheme.primaryColor.withOpacity(0.5),
                    color: Colors.white // .withOpacity(0.5),
                    ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'What do you want to eat?',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Right side - filter button
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(FilterScreen.route);
            },
            child: Ink(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white //.withOpacity(0.5),
                  // color: appTheme.primaryColor.withOpacity(0.5),
                  ),
              child: Icon(Icons.filter_list_rounded),
            ),
          )
        ],
      ),
    );
  }
}
