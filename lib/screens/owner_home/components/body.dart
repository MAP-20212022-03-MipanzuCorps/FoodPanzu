import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_viewmodel.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          View<OwnerHomeViewModel>(
            builder: (_, viewmodel) => DefaultButton(
              text: "Sign out",
              press: () {
                viewmodel.signOut();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, LogOutSuccessScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
    // Container(
    //   // child: SingleChildScrollView(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       View<HomeViewModel>(
    //         builder: (_, viewmodel) => DefaultButton(
    //           text: "Sign out",
    //           press: () {
    //             viewmodel.signOut();
    //             // if all are valid then go to success screen
    //             Navigator.pushNamed(context, LogOutSuccessScreen.routeName);
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    //   // ),
    // );
  }
}
