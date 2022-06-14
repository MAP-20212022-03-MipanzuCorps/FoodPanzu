import 'package:flutter/material.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/body.dart';

class RestaurantMenuScreen extends StatelessWidget {
  static String routeName = "/restaurantmenu";
  RestaurantMenuScreen({super.key});
  // RestaurantMenuScreen({super.key, this.restaurant});

  // Restaurant? restaurant;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Menu'),
      ),
      body: Body(),
    );
  }
}
