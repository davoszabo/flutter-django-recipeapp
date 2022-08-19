import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/providers/favorites.dart';
import 'package:flutter_app/providers/recipes.dart';
// import 'package:flutter_app/screens/fetch_test.dart';
import 'package:provider/provider.dart';

import '../providers/recipes.dart';
import '../providers/favorites.dart';

class RecipeDetailsScreen extends StatefulWidget {
  static const route = '/recipe-detail';

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  Widget buildSectionTitle(String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildContainer(
      Widget child, double height, double margin, double padding) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: padding),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as int; // String
    // final recipeLoaded = Provider.of<Recipes>(
    //   // Recipes
    //   context,
    //   listen: false,
    // ).fetchById(recipeId);
    // print(recipeLoaded.name);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future:
              Provider.of<Recipes>(context, listen: false).fetchById(recipeId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                      height: 250,
                      width: double.infinity,
                      child: (snapshot.data.image_url) == null
                          ? Image.network(
                              "https://render.fineartamerica.com/images/rendered/default/greeting-card/images-medium-5/sad-food-face-science-photo-library.jpg?&targetx=-25&targety=0&imagewidth=751&imageheight=500&modelwidth=700&modelheight=500&backgroundcolor=ECE9E6&orientation=0",
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              snapshot.data.image_url,
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          snapshot.data.description,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    buildSectionTitle('Instructions'),
                    buildContainer(
                      ListView.builder(
                        itemBuilder: (ctx, index) => Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  '${index + 1}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              title: Text(snapshot.data.steps[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Divider(),
                          ],
                        ),
                        itemCount: snapshot.data.steps.length,
                      ),
                      300,
                      5,
                      0,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            } else {
              // By default show a loading spinner.
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FutureBuilder(
          future: Provider.of<Favorites>(context, listen: true).fetchFavIds(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              List ids = snapshot.data;
              // return Consumer<Favorites>(
              //   builder: (context, value, child) =>
              return Icon(
                ids.contains(recipeId) ? Icons.star : Icons.star_border,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
          // isFavourite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          Provider.of<Favorites>(context, listen: false)
              .toggleFav(recipeId); // toggleFavourite(mealId);
        },
      ),
    );
  }
}
