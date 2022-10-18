import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/settings.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final settingData = Provider.of<Settings>(context, listen: false);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: settingData.items.length,
            itemBuilder: (context, index) {
              String id = settingData.items[index].id;
              String display_name = settingData.items[index].display_name;
              int value = settingData.items[index].value;
              return Center(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 40),
                  title: Text(display_name),
                  value: (value == 0) ? false : true,
                  onChanged: (bool value) {
                    setState(() {
                      settingData.switchValueOfSetting(id);
                    });
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            child: Text("Logout"),
            onPressed: authData.logout,
          ),
        ],
      ),
    );
  }
}
