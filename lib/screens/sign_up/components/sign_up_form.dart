// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/components/form_error.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_signup_screen.dart';
import 'package:foodpanzu/screens/sign_up/sign_up_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:foodpanzu/utils/enums.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String? conform_password;

  Role? role = Role.customer;

  final List<String?> errors = [];

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

  Future<void Function()?> _onRegister(
      BuildContext context, SignUpViewModel viewmodel) async {
    // ignore: duplicate_ignore
    try {
      await viewmodel.register();
      viewmodel.navigator(context);
            
    } on Failure catch (f) {
      final snackbar = SnackBar(
        content: Text(f.message ?? 'Error'),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: View<SignUpViewModel>(
        builder: (_, viewmodel) => Column(children: <Widget>[
          //name section
          TextFormField(
            onSaved: (newValue) => viewmodel.name = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              viewmodel.name = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //email section
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => viewmodel.email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              viewmodel.email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //password section
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => viewmodel.password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              viewmodel.password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //confirm password section
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => conform_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty &&
                  viewmodel.getpassword == conform_password) {
                removeError(error: kMatchPassError);
              }
              conform_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if ((viewmodel.getpassword != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),

          //role section
          Column(
            children: <Widget>[
              Text(
                'Are you a',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              ListTile(
                title: const Text('Customer'),
                leading: Radio(
                  value: Role.customer,
                  groupValue: role,
                  onChanged: (Role? value) {
                    setState(() {
                      role = value;
                      viewmodel.role = EnumToString.convertToString(value);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Owner'),
                leading: Radio(
                  value: Role.owner,
                  groupValue: role,
                  onChanged: (Role? value) {
                    setState(() {
                      role = value;
                      viewmodel.role = EnumToString.convertToString(value);
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                _onRegister(context, viewmodel);
              }
            },
          ),
        ]),
      ),
    );
  }
}
