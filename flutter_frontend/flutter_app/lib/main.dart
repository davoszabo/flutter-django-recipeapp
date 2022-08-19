import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:flutter_app/screens/recipes_screen.dart';
import 'package:flutter_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/recipe_details_screen.dart';
import 'screens/filter_screen.dart';
// import 'screens/fetch_test.dart';

// Providers
import './providers/recipes.dart';
import './providers/cuisines.dart';
import './providers/auth.dart';
import './providers/favorites.dart';
import './providers/filters.dart';

// Theme
import './common/theme.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Recipes(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Favorites>(
          update: (ctx, auth, previousProducts) => Favorites(
              auth.token,
              auth.getUserId,
              previousProducts == null ? [] : previousProducts.favitems),
        ),
        ChangeNotifierProvider(
          create: (_) => Filters(),
        ),
      ],
      // child: Consumer<Auth>(
      //   builder: (ctx, auth, _) => MaterialApp(
      //     title: "RecipeApp",
      //     theme: appTheme,
      //     home: auth.isAuth
      //         ? TabsScreen()
      //         : FutureBuilder(
      //             future: auth.tryAutoLogin(),
      //             builder: (ctx, authResultSnapshot) => (auth.isAuth &&
      //                     authResultSnapshot.connectionState ==
      //                         ConnectionState.waiting)
      //                 ? SplashScreen()
      //                 : AuthScreen(),
      //           ),
      //     routes: {
      //       RecipeDetailsScreen.route: (ctx) => RecipeDetailsScreen(),
      //       SearchScreen.route: (ctx) => SearchScreen(),
      //       FilterScreen.route: (ctx) => FilterScreen(),
      //       // MealDetailScreen.route: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
      //       // FiltersScreen.route: (ctx) => FiltersScreen(_filters, _setFilters),
      //     },
      //     onUnknownRoute: (settings) {
      //       return MaterialPageRoute(builder: (ctx) => RecipesScreen());
      //     },
      //   ),
      // ),
      child: MaterialApp(
        title: "RecipeApp",
        theme: appTheme,
        home: TabsScreen(),
        routes: {
          RecipeDetailsScreen.route: (ctx) => RecipeDetailsScreen(),
          SearchScreen.route: (ctx) => SearchScreen(),
          FilterScreen.route: (ctx) => FilterScreen(),
          // MealDetailScreen.route: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
          // FiltersScreen.route: (ctx) => FiltersScreen(_filters, _setFilters),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => RecipesScreen());
        },
      ),
    );
  }
}
