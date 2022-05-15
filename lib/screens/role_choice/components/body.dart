import 'package:flutter/material.dart';
import 'package:foodpanzu/constants.dart';
import 'package:foodpanzu/size_config.dart';

import 'role_choice.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Are you a", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                RoleChoice(),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
