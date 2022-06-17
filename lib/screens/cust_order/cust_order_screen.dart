import 'package:flutter/material.dart';
import 'package:foodpanzu/components/cust_navbar.dart';
import 'package:foodpanzu/screens/cust_order/components/body.dart';
import 'package:foodpanzu/screens/cust_order/cust_order_viewmodel.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:map_mvvm/map_mvvm.dart';

class CustOrderScreen extends StatelessWidget {
  static String routeName = "/cust_order";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: View<CustOrderViewModel>(
      builder: (_, viewmodel) => Body(viewmodel: viewmodel),),
      bottomNavigationBar: CustBottomNavBar(selectedMenu: MenuState.orders),
    );
   
  }
}