// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/components/form_error.dart';
import 'package:foodpanzu/components/no_account_text.dart';
import 'package:foodpanzu/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:foodpanzu/screens/sign_in/components/sign_form.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/ui_utils.dart';
import '../../sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  ForgotPassForm({
    Key? key,
  }) : super(key: key);
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];

  //forgot password model
  var forgotPassModel = forgotPasswordModel();

  void Function()? _onForgetEmailPressed(
      BuildContext context, forgotPasswordModel viewModel) {
    return () async {
      SnackBar snackbar;
      try {
        await viewModel.forgotPassword(viewModel.email);
        snackbar = SnackBar(
          content: Text("send sucessfully"),
        );
      } on Failure catch (f) {
        snackbar = SnackBar(
          content: Text(f.message ?? 'Error'),
          backgroundColor: Colors.red,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: View<forgotPasswordModel>(
        builder: (_, viewModel) => Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => viewModel.email = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.remove(kEmailNullError);
                  });
                } else if (emailValidatorRegExp.hasMatch(value) &&
                    errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.remove(kInvalidEmailError);
                  });
                }
                viewModel.email = value;
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kEmailNullError);
                  });
                } else if (!emailValidatorRegExp.hasMatch(value) &&
                    !errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.add(kInvalidEmailError);
                  });
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
            FormError(errors: errors),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(56),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: _onForgetEmailPressed(
                  context,
                  viewModel,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            NoAccountText(),
          ],
        ),
      ),
    );
  }
}
