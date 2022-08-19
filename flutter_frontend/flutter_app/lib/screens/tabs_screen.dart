import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/screens/auth_screen.dart';
import 'package:flutter_app/screens/recommend_screen.dart';
import 'package:flutter_app/screens/settings_screen.dart';
import 'package:flutter_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'recipes_screen.dart';
import './favorites_screen.dart';
import './recommend_screen.dart';
import './settings_screen.dart';
import './fetch_test.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> pages = [
    // FetchTestScreen(),
    RecipesScreen(),
    FavoritesScreen(),
    RecommendScreen(),
    Consumer<Auth>(
      builder: (ctx, auth, _) {
        return auth.isAuth
            ? SettingScreen()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) => (auth.isAuth &&
                        authResultSnapshot.connectionState ==
                            ConnectionState.waiting)
                    ? SplashScreen()
                    : AuthScreen(),
              );
      },
    ),
  ];

  int currentPageIndex = 0;

  final pageController = PageController();
  void selectPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Recipe App'),
      // ),
      body: PageView(
        children: pages,
        controller: pageController,
        onPageChanged: selectPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: pageController.jumpToPage,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
        currentIndex: currentPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recommended',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
