import 'package:flutter/material.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/screens/edit_menu/components/body.dart';
import 'package:foodpanzu/screens/edit_menu/edit_menu_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';

class EditMenuScreen extends StatelessWidget {
  static String routeName = "/edit_menu";
  Menu menu;
  EditMenuScreen({super.key, required this.menu});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Menu",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: Body(menu: menu),
    );
  }
}
