// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodpanzu/components/custom_surfix_icon.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/components/form_error.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_screen.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/size_config.dart';

class RestaurantForm extends StatefulWidget {
  const RestaurantForm({super.key});

  @override
  State<RestaurantForm> createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  final pictureController = TextEditingController();

  PlatformFile? pickedFile;
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

  Future<void Function()?> _onSignUpRestaurant(
      BuildContext context, RestaurantViewModel viewmodel) async {
    // ignore: duplicate_ignore
    try {
      await viewmodel.registerRestaurant();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => OwnerHomeScreen(),
        ),
        (route) => false,
      );
      Navigator.popUntil(context, (route) => route.isFirst);
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
      child: View<RestaurantViewModel>(
        builder: (_, viewmodel) => Column(children: <Widget>[
          //ssm section
          TextFormField(
            onSaved: (newValue) => viewmodel.ssmNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              viewmodel.ssmNumber = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "SSM Registration Number",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hintText: "Enter the company SSM Number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //email section
          TextFormField(
            onSaved: (newValue) => viewmodel.restName = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              viewmodel.restName = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Restaurant Name",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hintText: "Enter the restaurant name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //address section
          TextFormField(
            onSaved: (newValue) => viewmodel.restAddress = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kAddressNullError);
              } else if (addressValidator.hasMatch(value)) {
                removeError(error: kAddressInvalidError);
              }
              viewmodel.restAddress = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              } else if (!addressValidator.hasMatch(value)) {
                addError(error: kAddressInvalidError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Address",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hintText: "Enter restaurant address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //zip code section
          TextFormField(
            onSaved: (newValue) => viewmodel.restZipCode = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kZipCodeNullError);
              } else if (zipCodeValidator.hasMatch(value)) {
                removeError(error: kZipCodeInvalidError);
              }
              viewmodel.restZipCode = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kZipCodeNullError);
                return "";
              } else if (!zipCodeValidator.hasMatch(value)) {
                addError(error: kZipCodeInvalidError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Zip Code",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hintText: "Enter restaurant zip code",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),

          //description section
          TextFormField(
            onSaved: (newValue) => viewmodel.restDesc = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kDescNullError);
              }
              viewmodel.restDesc = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kDescNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Restaurant Description",
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
              hintText: "Enter the restaurant description",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),

          SizedBox(height: SizeConfig.screenHeight * 0.03),
          Container(
            child: TextFormField(
              onTap: () async {
                //use file picker to get image from devices
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No file selected")),
                  );

                  return null;
                }
                viewmodel.filepath = result.files.single.path!;
                pictureController.text = result.files.single.name;
              },
              controller: pictureController,
              onSaved: (newValue) {
                viewmodel.restPicture = newValue!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Don't leave the field blank!";
                }
              },
              readOnly: true,
              enableInteractiveSelection: true,
              decoration: const InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.upload),
                ),
                labelText: "Restaurant Picture",
                labelStyle: TextStyle(
                  color: Color(0xFFFF7643),
                ),
                hintText: "Insert your picture",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                _onSignUpRestaurant(context, viewmodel);
              }
            },
          ),
        ]),
      ),
    );
  }
}
