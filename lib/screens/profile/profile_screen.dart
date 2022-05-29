import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodpanzu/components/coustom_bottom_nav_bar.dart';
import 'package:foodpanzu/screens/profile/profile_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:map_mvvm/map_mvvm.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: kSecondaryColor)),
        actions: [View<ProfileViewModel>(
          builder: (_,viewmodel) {
            return InkWell(
                        child: SvgPicture.asset("assets/icons/Log out.svg"),
                        onTap: () {
                          viewmodel.signOut(context);
                        },
                      );
          }
        ),
                  const SizedBox(width: 12),
        ],
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
