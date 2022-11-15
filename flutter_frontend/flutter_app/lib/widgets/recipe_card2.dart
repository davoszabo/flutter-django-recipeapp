// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hungry/models/core/recipe.dart';
// import 'package:hungry/views/screens/recipe_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_color.dart';

import '../screens/recipe_details_screen2.dart';

import '../providers/recipes.dart';
import '../providers/settings.dart';

class RecipeCard2 extends StatelessWidget {
  final int recipeId;

  RecipeCard2(this.recipeId);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    final recipesProvided = Provider.of<Recipes>(context);

    var recipes = recipesProvided.items;

    if (settings.getValueById("showOnlyWithImage") == 1) {
      recipes = recipes.where((element) => element.image_url != null).toList();
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RecipeDetailsScreen2.route,
            arguments: recipes[recipeId].id // data.items[index].id,
            );
      },
      child: Container(
        height: 140,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            // Recipe Photo
            Container(
              width: 150,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: (recipes[recipeId].image_url) != null
                      ? NetworkImage(recipes[recipeId].image_url)
                      : AssetImage("assets/images/no_image_found.jpg"),
                  // : NetworkImage(
                  //       "https://render.fineartamerica.com/images/rendered/default/greeting-card/images-medium-5/sad-food-face-science-photo-library.jpg?&targetx=-25&targety=0&imagewidth=751&imageheight=500&modelwidth=700&modelheight=500&backgroundcolor=ECE9E6&orientation=0"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Recipe Info
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe title
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        recipes[recipeId].name,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          // fontFamily: 'inter',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    // Recipe details
                    Row(
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
                            '${recipes[recipeId].minutes}',
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
                            '${recipes[recipeId].rating}',
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
                            '${recipes[recipeId].review_count}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
