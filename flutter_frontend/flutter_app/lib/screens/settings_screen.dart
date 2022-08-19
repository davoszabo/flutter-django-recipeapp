import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    return Container(
      child: Center(
          child: ElevatedButton(
        child: Text("Logout"),
        onPressed: authData.logout,
      )),
      color: Colors.lightGreenAccent,
    );
  }
}
