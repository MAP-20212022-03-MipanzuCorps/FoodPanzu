// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:foodpanzu/screens/role_choice/role_choice_viewmodel.dart';

// import '../../../constants.dart';
import '../../../size_config.dart';

class RoleChoice extends StatefulWidget {
  const RoleChoice({Key? key}) : super(key: key);

  @override
  _RoleChoiceState createState() => _RoleChoiceState();
}

class _RoleChoiceState extends State<RoleChoice> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? role;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(40)),
          View<RoleChoiceViewModel>(
            builder: (_, viewmodel) => DefaultButton(
              text: "Restaurant owner",
              press: () {
                if (_formKey.currentState!.validate()) {
                  role = 'owner';
                  viewmodel.roleChosen(role);
                }
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          const Text('or',style: TextStyle(fontSize: 20)),
          SizedBox(height: getProportionateScreenHeight(30)),
          View<RoleChoiceViewModel>(
            builder: (_, viewmodel) => DefaultButton(
              text: "Customer",
              press: () {
                if (_formKey.currentState!.validate()) {
                  role = 'customer';
                  viewmodel.roleChosen(role);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
