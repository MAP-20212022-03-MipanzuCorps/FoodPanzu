import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
import 'package:foodpanzu/utils/enums.dart';

import 'components/body.dart';

class DashboardScreen extends StatelessWidget {
  static String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"),),
    body: Body(),
    bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.dashboard),
    );
    
  }
}