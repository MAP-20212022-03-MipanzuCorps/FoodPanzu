import 'package:flutter/material.dart';

import 'components/body.dart';

class LogOutSuccessScreen extends StatelessWidget {
  static String routeName = "/logout_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Logout Success"),
      ),
      body: Body(),
    );
  }
}
