// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hungry/models/core/recipe.dart';
// import 'package:hungry/views/screens/recipe_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_color.dart';

import '../screens/recipe_details_screen.dart';
import '../screens/recipe_details_screen2.dart';
import '../providers/recipes.dart';
import '../providers/recommendations.dart';

class RecommendCard2 extends StatelessWidget {
  final int recipeId;

  RecommendCard2(this.recipeId);

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<Recommendations>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RecipeDetailsScreen2.route,
            arguments: recipes.recitems[recipeId].id // data.items[index].id,
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
                  image: (recipes.recitems[recipeId].image_url) != null
                      ? NetworkImage(recipes.recitems[recipeId].image_url)
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
                        recipes.recitems[recipeId].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'inter',
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
                            '${recipes.recitems[recipeId].minutes}',
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
                            '${recipes.recitems[recipeId].rating}',
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
                            '${recipes.recitems[recipeId].review_count}',
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
