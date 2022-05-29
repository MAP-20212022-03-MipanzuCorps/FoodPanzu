import 'package:flutter/material.dart';
import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/add_new_menu/add_new_menu_screen.dart';
import 'package:foodpanzu/screens/menu_details/menu_details_screen.dart';
import 'package:foodpanzu/screens/owner_home/components/body.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/utils/enums.dart';
// import 'package:foodpanzu/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
// import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
// import 'package:foodpanzu/enums.dart';
// import 'components/body.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/menu_cart.dart';
import 'ownerhome_viewmodel.dart';

class OwnerHomeScreen extends StatelessWidget {
  static String routeName = "/ownerhome";
  @override
  Widget build(BuildContext context) {
    return View<OwnerHomeViewModel>(
      builder: (_, viewmodel) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: true,
                pinned: true,
                collapsedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/pizza.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "West Stop",
                          style: TextStyle(
                            color: Color.fromARGB(255, 47, 44, 44),
                          ),
                        ),
                        Text(
                          "Western Hub",
                          style: TextStyle(color: Color(0xFFFF7643)),
                        ),
                      ],
                    )
                    // titlePadding: EdgeInsets.only(left: 500),
                    ),
                //title: Text('My App Bar'),
                leading: AppBar(),
                //actions for sign out later on
                actions: [
                  InkWell(
                    child: Icon(Icons.settings),
                    onTap: () {
                      viewmodel.signOut();
                      // Navigator.pushNamed(context, SignInScreen.routeName);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LogOutSuccessScreen(),
                        ),
                        (route) => false,
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              Body(viewmodel: viewmodel),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.home),
        );
      },
    );
  }
}
