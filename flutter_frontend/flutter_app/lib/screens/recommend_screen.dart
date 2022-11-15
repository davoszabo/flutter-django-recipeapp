import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recommendations.dart';
import '../providers/settings.dart';

import '../widgets/rec_card2.dart';

class RecommendScreen extends StatefulWidget {
  @override
  RecommendScreenState createState() => RecommendScreenState();
}

class RecommendScreenState extends State<RecommendScreen> {
  Future futureData;

  Future obtainFutureData() {
    final settings = Provider.of<Settings>(context, listen: false);
    return Provider.of<Recommendations>(context, listen: false)
        .fetchRecData(settings.getValueById("enableSVD") == 0 ? "KNN" : "SVD");
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
        title: Text("Recommendations",
            style: TextStyle(
                // fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                fontSize: 22)),
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
              return Consumer<Recommendations>(
                builder: (ctx, data, child) => ListView.builder(
                  itemCount: data.recitems.length,
                  itemBuilder: (context, index) {
                    // print(data.items.length);
                    return RecommendCard2(index);
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
