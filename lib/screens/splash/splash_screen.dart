// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_screen.dart';
// import 'package:foodpanzu/screens/splash/components/body.dart';
import 'package:foodpanzu/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Splash.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButton(
              text: "Continue",
              press: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
        // SizedBox(height: getProportionateScreenHeight(10)),
      ],
    )
        // Body(),
        );
  }
}
