import 'package:flutter/material.dart';

class MenuDetailScreen extends StatelessWidget {
  static String routeName = "/menu_detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu details"),
      ),
      body: Text("Menu details"),
    );
  }
}
