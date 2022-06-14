import 'package:flutter/material.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/body.dart';

class RestaurantMenuScreen extends StatelessWidget {
  static String routeName = "/restaurant_menu";
  RestaurantMenuScreen(
      {super.key, required this.restaurant, required this.menuList});

  Restaurant restaurant;
  Future<List<Menu>> menuList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Menu'),
      ),
      body: Body(restaurant: restaurant, menuList: menuList),
    );
  }
}
