import 'package:flutter/material.dart';
import 'package:flutter_app/providers/recipes.dart';
import 'package:provider/provider.dart';

import '../screens/recipe_details_screen.dart';
import '../providers/recipes.dart';

class RecipeCard extends StatelessWidget {
  final int recipeId;

  RecipeCard(this.recipeId);

  @override
  Widget build(BuildContext context) {
    // final recipeId = ModalRoute.of(context).settings.arguments as int; // String
    // final recipeLoaded = Provider.of<Cuisines>(
    //   // Recipes
    //   context,
    //   listen: false,
    // ).findById(recipeId);
    final recipes = Provider.of<Recipes>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RecipeDetailsScreen.route,
            arguments: recipes.items[recipeId].id // data.items[index].id,
            );
      },
      // child: Card(
      //   child: ListTile(
      //     title: Text(
      //       "${data.items[index].name}",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      //   color: Colors.green,
      // ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: (recipes.items[recipeId].image_url) == null
                      ? Image.network(
                          "https://render.fineartamerica.com/images/rendered/default/greeting-card/images-medium-5/sad-food-face-science-photo-library.jpg?&targetx=-25&targety=0&imagewidth=751&imageheight=500&modelwidth=700&modelheight=500&backgroundcolor=ECE9E6&orientation=0",
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          recipes.items[recipeId].image_url,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      recipes.items[recipeId].name,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${recipes.items[recipeId].minutes}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${recipes.items[recipeId].n_ingredients}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 35,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${recipes.items[recipeId].n_steps}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
