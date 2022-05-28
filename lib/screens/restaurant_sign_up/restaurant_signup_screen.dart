import 'package:flutter/material.dart';

import 'components/body.dart';

class RestaurantSignUpScreen extends StatelessWidget {
  static String routeName = "/restaurant_sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Sign Up"),
      ),
      body: Body(),
    );
  }
}
