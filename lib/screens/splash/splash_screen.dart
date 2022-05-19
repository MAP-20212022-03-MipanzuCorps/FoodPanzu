// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_screen.dart';
import 'package:foodpanzu/screens/splash/splash_viewmodel.dart';
// import 'package:foodpanzu/screens/splash/components/body.dart';
import 'package:foodpanzu/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';

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
        View<SplashViewModel>(
          builder: (_, viewModel) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultButton(
                text: "Continue",
                press: () {
                  '${viewModel.userHasSignIn() ? Navigator.pushNamed(context, HomeScreen.routeName) : Navigator.pushNamed(context, SignInScreen.routeName)}';
                },
              ),
            ],
          ),
        )
        // SizedBox(height: getProportionateScreenHeight(10)),
      ],
    )
        // Body(),
        );
  }
}
