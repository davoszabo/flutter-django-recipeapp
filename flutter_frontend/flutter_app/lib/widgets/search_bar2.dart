import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../screens/filter_screen.dart';

import '../common/theme.dart';

class SearchBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.red,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     blurRadius: 2.0,
        //     spreadRadius: 0.0,
        //     offset: Offset(0.5, 0.5), // shadow direction: bottom right
        //   )
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Left side - Search Box
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: appTheme.primaryColor.withOpacity(0.5),
                    color: Colors.white // .withOpacity(0.5),
                    ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
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
            child: Container(
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
