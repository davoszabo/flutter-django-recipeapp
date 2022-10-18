import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/providers/recipes.dart';
import 'package:provider/provider.dart';

import '../screens/recipe_details_screen2.dart';
import '../providers/favorites.dart';

class FavoriteCard2 extends StatelessWidget {
  final int recipeId;

  FavoriteCard2(this.recipeId);

  @override
  Widget build(BuildContext context) {
    // final recipeId = ModalRoute.of(context).settings.arguments as int; // String
    // final recipeLoaded = Provider.of<Cuisines>(
    //   // Recipes
    //   context,
    //   listen: false,
    // ).findById(recipeId);
    final recipes = Provider.of<Favorites>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RecipeDetailsScreen2.route,
            arguments: recipes.favitems[recipeId].id // data.items[index].id,
            );
      },
      // Card Wrapper
      child: Container(
        margin: EdgeInsets.all(10),
        height: 220,
        alignment: Alignment.bottomCenter,
        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        padding: EdgeInsets.only(left: 8, right: 40, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: (recipes.favitems[recipeId].image_url) != null
                ? NetworkImage(recipes.favitems[recipeId].image_url)
                : AssetImage("assets/images/no_image_found.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // Recipe Card Info
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              height: 80,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Title
                  Text(
                    recipes.favitems[recipeId].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 150 / 120,
                      fontWeight: FontWeight.w700,
                      // fontFamily: 'inter',
                    ),
                  ),
                  // Recipe Calories and Time
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        // Minutes
                        Icon(
                          Icons.alarm,
                          size: 18,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text(
                            '${recipes.favitems[recipeId].minutes}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Rating
                        Icon(
                          Icons.star_border,
                          size: 18,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text(
                            '${recipes.favitems[recipeId].rating}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Reviews
                        Icon(
                          Icons.people_outline,
                          size: 18,
                          color: Colors.black,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 5,
                          ),
                          child: Text(
                            '${recipes.favitems[recipeId].review_count}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
