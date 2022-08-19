import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './recipe_details_screen.dart';

import '../providers/cuisines.dart';

import '../widgets/recipe_card.dart';

class CuisineScreen extends StatefulWidget {
  @override
  CuisineScreenState createState() => CuisineScreenState();
}

class CuisineScreenState extends State<CuisineScreen> {
  Future futureData;

  Future obtainFutureData() {
    return Provider.of<Cuisines>(context, listen: false).fetchData();
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
      body: Center(
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            // print(snapshot.connectionState);
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.connectionState == ConnectionState.done) {
              // List<Data> data = snapshot.data;
              return Consumer<Cuisines>(
                builder: (ctx, data, child) => ListView.builder(
                  itemCount: data.items.length,
                  itemBuilder: (context, index) {
                    // print(data.items.length);
                    return RecipeCard(index);
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(
                    //       RecipeDetailsScreen.route,
                    //       arguments: data.items[index].id,
                    //     );
                    //   },
                    //   // child: Card(
                    //   //   child: ListTile(
                    //   //     title: Text(
                    //   //       "${data.items[index].name}",
                    //   //       style: TextStyle(color: Colors.white),
                    //   //     ),
                    //   //   ),
                    //   //   color: Colors.green,
                    //   // ),
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)),
                    //     elevation: 4,
                    //     margin: EdgeInsets.all(10),
                    //     child: Column(
                    //       children: <Widget>[
                    //         Stack(
                    //           children: <Widget>[
                    //             ClipRRect(
                    //               borderRadius: BorderRadius.only(
                    //                   topLeft: Radius.circular(15),
                    //                   topRight: Radius.circular(15)),
                    //               child: Image.network(
                    //                 data.items[index].image_url,
                    //                 height: 250,
                    //                 width: double.infinity,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //             Positioned(
                    //               top: 0,
                    //               right: 0,
                    //               child: Container(
                    //                 width: 350,
                    //                 decoration: BoxDecoration(
                    //                     color: Colors.black54,
                    //                     borderRadius: BorderRadius.only(
                    //                         bottomLeft: Radius.circular(15),
                    //                         topRight: Radius.circular(15))),
                    //                 padding: EdgeInsets.symmetric(
                    //                     vertical: 5, horizontal: 15),
                    //                 child: Text(
                    //                   data.items[index].name,
                    //                   style: TextStyle(
                    //                     fontSize: 26,
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                   softWrap: true,
                    //                   overflow: TextOverflow.fade,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.all(10),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: <Widget>[
                    //               Row(
                    //                 children: <Widget>[
                    //                   Icon(Icons.schedule),
                    //                   SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   Text(
                    //                     '${data.items[index].prep_time}',
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Container(
                    //                 width: 1,
                    //                 height: 35,
                    //                 decoration:
                    //                     BoxDecoration(color: Colors.black),
                    //               ),
                    //               Row(
                    //                 children: <Widget>[
                    //                   Icon(Icons.work),
                    //                   SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   Text(
                    //                     data.items[index].diet,
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Container(
                    //                 width: 1,
                    //                 height: 35,
                    //                 decoration:
                    //                     BoxDecoration(color: Colors.black),
                    //               ),
                    //               Row(
                    //                 children: <Widget>[
                    //                   Icon(Icons.attach_money),
                    //                   SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   Text(
                    //                     data.items[index].cuisine,
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // );
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
