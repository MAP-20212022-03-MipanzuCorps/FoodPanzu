import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/components/owner_navbar.dart';
import 'package:foodpanzu/utils/enums.dart';

import 'components/body.dart';

class DashboardScreen extends StatelessWidget {
  static String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard", style: TextStyle(color: Colors.black)),),
    body: Body(),
    bottomNavigationBar: OwnerBottomNavBar(selectedMenu: MenuState.dashboard),
    );
    
  }
}