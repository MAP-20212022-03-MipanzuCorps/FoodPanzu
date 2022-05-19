import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
// import 'package:foodpanzu/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
// import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
// import 'package:foodpanzu/enums.dart';
// import 'components/body.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:

          // SearchField(),
          Center(
        child: View<HomeViewModel>(
          builder: (_, viewmodel) => DefaultButton(
            text: "Sign out",
            press: () {
              viewmodel.signOut();
              // if all are valid then go to success screen
              Navigator.pushNamed(context, LogOutSuccessScreen.routeName);
            },
          ),
        ),
      ),

      // Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
