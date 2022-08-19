import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/recipes.dart';
import './recipe_card.dart';
import '../providers/recipes.dart';

class RecipeList extends StatelessWidget {
  // final bool showFavourites;
  // ProductsGrid(this.showFavourites);

  @override
  Widget build(BuildContext context) {
    final recipesData = Provider.of<Recipes>(context);
    final recipes = recipesData.items;
    // showFavourites ? recipesData.favouriteItems : recipesData.items;
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: recipes.length,
      itemBuilder: (context, index) => Provider.value(
        value: recipes[index],
        child: RecipeCard(index),
      ),
    );
  }
}
