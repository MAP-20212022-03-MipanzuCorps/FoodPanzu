import 'package:flutter/material.dart';
import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_viewmodel.dart';
import 'package:foodpanzu/screens/owner_order/components/body.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_viewmodel.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:map_mvvm/map_mvvm.dart';

class OwnerOrderScreen extends StatelessWidget {
  static String routeName = "/owner_order";
  @override
  Widget build(BuildContext context) {
    return View<OwnerOrderViewModel>(
      builder: (_, viewmodel) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: Body(viewmodel: viewmodel),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
   });
  }
}