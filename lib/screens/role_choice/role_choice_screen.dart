import 'package:flutter/material.dart';

import 'components/body.dart';

class RoleChoiceScreen extends StatelessWidget {
  static String routeName = "/role_choice";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
