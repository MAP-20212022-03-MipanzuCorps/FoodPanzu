// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/profile/profile_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  _onUpdate(ProfileViewModel viewmodel) async {
    try {
      await viewmodel.updateProfile();

      var snackbar = SnackBar(
        content: Text('Updated Successful'),
        backgroundColor: Color.fromARGB(255, 0, 100, 52),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on Failure catch (e) {
      final snackbar = SnackBar(
        content: Text(e.message ?? 'Error'),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return View<ProfileViewModel>(
      builder: (_, viewmodel) => RefreshIndicator(
        onRefresh: () {
            viewmodel.refreshPage();
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePic(),
                  SizedBox(height: 30),
                  TextFormField(
                    initialValue: '${viewmodel.user.name}',
                    onSaved: (newValue) => viewmodel.name = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {}
                      viewmodel.name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be null";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon:
                          CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('${viewmodel.user.email}'),
                  SizedBox(height: 20),
                  DefaultButton(
                    text: "Update",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        _onUpdate(viewmodel);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
