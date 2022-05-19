// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/form_error.dart';
import 'package:foodpanzu/helper/keyboard.dart';
import 'package:foodpanzu/screens/forgot_password/forgot_password_screen.dart';
import 'package:foodpanzu/screens/login_success/login_success_screen.dart';
import 'package:foodpanzu/ui_utils.dart';
import 'package:map_mvvm/map_mvvm.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../sign_in_viewmodel.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
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

  Future<void Function()?> _onSignIn(
    BuildContext context, SignInViewModel viewmodel)async{
      try {
        await viewmodel.signInWithEmailAndPassword(email, password);
        Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      }on Failure catch (f) {
        final snackbar = SnackBar(content: Text(f.message ?? 'Error'),
          backgroundColor: Colors.red,);
      }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              // Checkbox(
              //   value: remember,
              //   activeColor: kPrimaryColor,
              //   onChanged: (value) {
              //     setState(() {
              //       remember = value;
              //     });
              //   },
              // ),
              // Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          View<SignInViewModel>(
            builder: (_, viewmodel) => DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    viewmodel.signInWithEmailAndPassword(email, password);
                    KeyboardUtil.hideKeyboard(context);
                    // if all are valid then go to success screen
                    showSnackBarWhenError(context, () async {
                      return viewmodel.signInWithEmailAndPassword(email, password);
                    });
                    _onSignIn(context, viewmodel);
                    //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                }),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
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
    );
  }
}
