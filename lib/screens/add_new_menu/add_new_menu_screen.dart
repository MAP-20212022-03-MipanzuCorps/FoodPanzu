import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/add_new_menu/components/body.dart';

class AddNewMenuScreen extends StatelessWidget {
  static String routeName = "/add_menu";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add New Menu",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: Body(),
    );
  }
}
