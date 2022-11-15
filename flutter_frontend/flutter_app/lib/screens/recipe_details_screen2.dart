//import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_color.dart';

import '../providers/recipes.dart';
import '../providers/favorites.dart';

class RecipeDetailsScreen2 extends StatefulWidget {
  static const route = '/recipe-detail2';

  @override
  _RecipeDetailsScreen2State createState() => _RecipeDetailsScreen2State();
}

class _RecipeDetailsScreen2State extends State<RecipeDetailsScreen2>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.5);
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = AppColor.primary;
        });
      }
      if (scrollController.position.pixels <= 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
    }
  }

  // fab to write review
  showFAB(TabController tabController) {
    int reviewTabIndex = 2;
    if (tabController.index == reviewTabIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as int; // String
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AnimatedContainer(
          // color: Colors.red,
          duration: Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            // brightness: Brightness.dark,
            elevation: 0,
            centerTitle: true,
            // title: Text('Search Recipe',
            //     style: TextStyle(
            //         fontFamily: 'inter',
            //         fontWeight: FontWeight.w400,
            //         fontSize: 14)),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              FutureBuilder(
                future:
                    Provider.of<Favorites>(context, listen: true).fetchFavIds(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      // return CircularProgressIndicator();
                      case ConnectionState.none:
                      case ConnectionState.active:
                        return Icon(Icons.bookmark_outline);
                      case ConnectionState.done:
                        List ids = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: ids.contains(recipeId)
                                ? Icon(
                                    Icons.bookmark,
                                    size: 34,
                                  )
                                : Icon(
                                    Icons.bookmark_border_outlined,
                                    size: 34,
                                  ),
                            onTap: () {
                              Provider.of<Favorites>(context, listen: false)
                                  .toggleFav(
                                      recipeId); // toggleFavourite(mealId);
                            },
                          ),
                        );
                    }
                  }
                },
                // isFavourite(mealId) ? Icons.star : Icons.star_border,
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.bookmark_border),
              //   iconSize: 34,
              // ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<Recipes>(context, listen: false).fetchById(recipeId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              // controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              children: [
                // Section 1 - Recipe Image
                Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (snapshot.data.image_url != null)
                              ? NetworkImage(snapshot.data.image_url)
                              : AssetImage("assets/images/no_image_found.jpg"),
                          fit: BoxFit.cover)),
                  child: Container(
                    decoration:
                        BoxDecoration(gradient: AppColor.linearBlackTop),
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                // Section 2 - Recipe Info
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(top: 20, bottom: 30, left: 16, right: 16),
                  color: Colors.red.shade900,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Calories and Time
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "${snapshot.data.minutes}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.star_border,
                            size: 16,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "${snapshot.data.rating}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.people_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "${snapshot.data.review_count}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Recipe Title
                      Container(
                        margin: EdgeInsets.only(bottom: 12, top: 16),
                        child: Text(
                          snapshot.data.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'inter'),
                        ),
                      ),
                      // Recipe Description
                      Text(
                        snapshot.data.description,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            height: 150 / 100),
                      ),
                    ],
                  ),
                ),
                // Tabbar ( Ingridients, Tutorial, Reviews )
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.secondary,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black.withOpacity(0.6),
                    labelStyle: TextStyle(
                        fontFamily: 'inter', fontWeight: FontWeight.w500),
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'Ingredients',
                      ),
                      Tab(
                        text: 'Tutorial',
                      ),
                      // Tab(
                      //   text: 'Reviews',
                      // ),
                    ],
                  ),
                ),
                // IndexedStack based on TabBar index
                IndexedStack(
                  index: _tabController.index,
                  children: [
                    // Ingridients
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data.ingredients.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[350], width: 1))),
                          child: Text(
                            snapshot.data.ingredients_raw_str[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 150 / 120),
                          ),
                        );
                      },
                    ),
                    // Tutorials
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data.steps.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[350], width: 1))),
                          child: (snapshot.data.steps != null)
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${snapshot.data.steps}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        height: 150 / 100),
                                  ),
                                )
                              : SizedBox(),
                        );
                      },
                    ),
                    // Reviews
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   padding: EdgeInsets.zero,
                    //   itemCount: widget.data.reviews.length,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     return ReviewTile(data: widget.data.reviews[index]);
                    //   },
                    // )
                  ],
                ),
              ],
            );
          } else {
            // By default show a loading spinner.
            return CircularProgressIndicator();
          }
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: FutureBuilder(
      //     future: Provider.of<Favorites>(context, listen: true).fetchFavIds(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         return Text("${snapshot.error}");
      //       } else if (snapshot.connectionState == ConnectionState.done) {
      //         List ids = snapshot.data;
      //         // return Consumer<Favorites>(
      //         //   builder: (context, value, child) =>
      //         return Icon(
      //           ids.contains(recipeId) ? Icons.star : Icons.star_border,
      //         );
      //       } else {
      //         return CircularProgressIndicator();
      //       }
      //     },
      //     // isFavourite(mealId) ? Icons.star : Icons.star_border,
      //   ),
      //   onPressed: () {
      //     Provider.of<Favorites>(context, listen: false)
      //         .toggleFav(recipeId); // toggleFavourite(mealId);
      //   },
      // ),
    );
  }
}
