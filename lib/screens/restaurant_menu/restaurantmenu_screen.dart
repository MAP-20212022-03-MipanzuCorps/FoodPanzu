import 'package:flutter/material.dart';
import 'package:foodpanzu/components/cust_navbar.dart';
import 'package:foodpanzu/screens/customer_cart/cart.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/body.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:foodpanzu/widgets/cart_button.dart';
import 'package:map_mvvm/map_mvvm.dart';

import 'restaurantmenu_viewmodel.dart';

class RestaurantMenuScreen extends StatelessWidget {
  static String routeName = "/restaurantmenu";
  RestaurantMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: const CustBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
