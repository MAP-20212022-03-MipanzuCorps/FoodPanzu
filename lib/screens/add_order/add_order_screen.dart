import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/screens/add_order/components/body.dart';

class AddOrderScreen extends StatelessWidget {
  static String routeName = "/add_order";
  Menu menu;
  AddOrderScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(menu: menu),
    );
  }
}
