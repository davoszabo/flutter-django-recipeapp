import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipes.dart';
import '../providers/filters.dart';

import '../widgets/recipe_card2.dart';
import '../widgets/search_bar2.dart';

class RecipesScreen extends StatefulWidget {
  @override
  RecipesScreenState createState() => RecipesScreenState();
}

class RecipesScreenState extends State<RecipesScreen>
    with AutomaticKeepAliveClientMixin<RecipesScreen> {
  Future futureData;

  bool keepAlive = true;

  Future obtainFutureData() {
    print(Provider.of<Filters>(context, listen: false)
        .items
        .where((e) => e.selected)
        .map((e) => e.name)
        .toList());
    return Provider.of<Recipes>(context, listen: false).fetchData(
        Provider.of<Filters>(context, listen: false)
            .items
            .where((e) => e.selected)
            .map((e) => e.name)
            .toList(),
        "");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    print("initialized");
    futureData = obtainFutureData();
  }

  TextEditingController _textEditingController = TextEditingController();

  void searchSubmit() {
    Provider.of<Recipes>(context, listen: false)
        .searchFetchData(_textEditingController.text);
    print(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Recipe App",
            style: TextStyle(
                // fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                fontSize: 24)),
      ),
      // backgroundColor: Colors.black12,
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureData = obtainFutureData();
            });
          },
          child: FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              // print(snapshot.connectionState);
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.connectionState == ConnectionState.done) {
                // List<Data> data = snapshot.data;
                return Consumer<Recipes>(
                  builder: (ctx, data, child) => Column(
                    // mainAxisSize:
                    //     MainAxisSize.min, //Add this line onyour column
                    children: [
                      // SafeArea(
                      //   child: Container(
                      //     padding: EdgeInsets.all(20),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           // color: Colors.grey),
                      //           child: TextField(
                      //             controller: _textEditingController,
                      //             decoration: InputDecoration(
                      //               fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                      //               filled: true,
                      //               border: OutlineInputBorder(),
                      //               hintText: 'Search',
                      //               suffixIcon: IconButton(
                      //                 onPressed: _textEditingController.clear,
                      //                 icon: Icon(Icons.clear),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         GestureDetector(
                      //           onTap: () {
                      //             FocusScope.of(context).unfocus();
                      //             searchSubmit();
                      //           },
                      //           child: Container(
                      //             margin: EdgeInsets.only(left: 20),
                      //             width: 50,
                      //             height: 50,
                      //             alignment: Alignment.center,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //             ),
                      //             child: Icon(Icons.search_rounded),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SafeArea(
                        child: SearchBar2(),
                        // child: Container(
                        //   // color: Colors.red,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: SearchBar2(),
                        //   ),
                        // ),
                      ),
                      // Divider(
                      //   thickness: 2,
                      //   height: 0,
                      // ),
                      Expanded(
                        child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: data.items.length,
                          itemBuilder: (context, index) {
                            // print(data.items.length);
                            return RecipeCard2(index);
                          },
                        ),
                      ),
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
      ),
    );
  }
}
