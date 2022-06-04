// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/owner_dashboard/dashboard_screen.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_screen.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_screen.dart';
import 'package:foodpanzu/screens/profile/profile_screen.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Plus Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, OwnerHomeScreen.routeName),
              ),
              IconButton(
                   icon: SvgPicture.asset(
                  "assets/icons/Bell.svg",
                  color: MenuState.favourite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, OwnerOrderScreen.routeName),
                    ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Dashboard Icon.svg",
                  color: MenuState.dashboard == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, DashboardScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.popAndPushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
