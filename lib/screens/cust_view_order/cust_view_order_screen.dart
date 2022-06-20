import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/screens/cust_view_order/components/body.dart';

class CustViewOrder extends StatelessWidget {
  const CustViewOrder({super.key});
  static String routeName = "/cust_view_order";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "View Orders",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: Body(),
     // bottomNavigationBar: CustBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}