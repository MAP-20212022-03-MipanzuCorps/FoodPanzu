import 'package:flutter/material.dart';
import 'package:foodpanzu/components/cust_navbar.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: const CustBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
