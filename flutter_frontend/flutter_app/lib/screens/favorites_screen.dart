import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites.dart';

import '../widgets/fav_card2.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  Future futureData;

  Future obtainFutureData() {
    return Provider.of<Favorites>(context, listen: false).fetchFavData();
  }

  @override
  void initState() {
    futureData = obtainFutureData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("ASD");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Favorites",
            style: TextStyle(
                // fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                fontSize: 24)),
      ),
      body: Center(
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              // List<Data> data = snapshot.data;
              return Consumer<Favorites>(
                builder: (ctx, data, child) => ListView.builder(
                  itemCount: data.favitems.length,
                  itemBuilder: (context, index) {
                    // print(data.items.length);
                    return FavoriteCard2(index);
                  },
                ),
              );
            } else {
              // By default show a loading spinner.
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
