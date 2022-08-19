import 'package:flutter/material.dart';

class RecommendScreen extends StatefulWidget {
  @override
  State<RecommendScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Recommendations")),
      color: Colors.pinkAccent,
    );
  }
}
