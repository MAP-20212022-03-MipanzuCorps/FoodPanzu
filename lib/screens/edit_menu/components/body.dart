import 'package:file_picker/file_picker.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/screens/add_new_menu/add_new_menu_viewmodel.dart';
import 'package:foodpanzu/screens/edit_menu/edit_menu_viewmodel.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/view.dart';
import 'dart:math';

import '../../../utils/constants.dart';
import '../edit_menu_viewmodel.dart';

class Body extends StatefulWidget {
  Menu menu;
  Body({super.key, required this.menu});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String foodName, foodDescription, foodPicture;
  String? foodCategory;
  late String path;
  late double price;
  final pictureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return View<EditMenuViewModel>(
      builder: (_, viewmodel) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  foodNameField(),
                  foodDescriptionField(),
                  foodCategoryField(),
                  foodPriceField(),
                  foodPictureField(viewmodel),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
                        child: SizedBox(
                          height: getProportionateScreenHeight(56),
                          width: 100,
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: Colors.red,
                            ), // delete button
                            onPressed: (() {
                              viewmodel.deleteMenu(widget.menu.menuId);
                              Navigator.pop(context);
                            }),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(56),
                        width: 100,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            primary: Colors.white,
                            backgroundColor: kPrimaryColor,
                          ),
                          onPressed: (() {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            viewmodel.editMenu(
                                Menu(
                                    menuId: widget.menu.menuId,
                                    category: foodCategory!,
                                    foodDesc: foodDescription,
                                    foodPrice: price,
                                    foodName: foodName,
                                    foodPicture:
                                        generateRandomString(2) + foodPicture),
                                path);
                              Navigator.pop(context);
                          }),
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column foodNameField() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        TextFormField(
          controller: TextEditingController()..text = widget.menu.foodName,
          //onChanged: (text) => {},
          onSaved: (newValue) => foodName = newValue!,
          validator: (value) {
            if (value!.isEmpty) {
              return "Don't leave the field blank!";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "FoodName",
            labelStyle: TextStyle(
              color: Color(0xFFFF7643),
            ),
            hintText: "Enter your foodName",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ],
    );
  }

  Column foodDescriptionField() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        Container(
          child: TextFormField(
            controller: TextEditingController()..text = widget.menu.foodDesc,
            onSaved: (newValue) => foodDescription = newValue!,
            validator: (value) {
              if (value!.isEmpty) {
                return "Don't leave the field blank!";
              }
            },
            decoration: const InputDecoration(
              labelText: "FoodDescription",
              labelStyle: TextStyle(
                color: Color(0xFFFF7643),
              ),
              hintText: "Enter the food description",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }

  Column foodCategoryField() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        Container(
          child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "FoodCategory",
                labelStyle: TextStyle(
                  color: Color(0xFFFF7643),
                ),
                hintText: "Enter your food category",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              value: foodCategory,
              hint: const Text(
                'Food Category',
              ),
              onChanged: (category) => setState(() => foodCategory = category),
              validator: (value) => value == null ? 'field required' : null,
              items: const [
                DropdownMenuItem(value: "food", child: Text("Food")),
                DropdownMenuItem(value: "drink", child: Text("Drink"))
              ]),
          //     DropdownButton(
          //   items: [
          //     DropdownMenuItem(child: Text("Food"), value: "food"),
          //     DropdownMenuItem(child: Text("Drink"), value: "drink")
          //   ],
          //   value: foodCategory,
          //   onChanged: (String? value) {
          //     foodCategory = value;
          //   },
          // )
          // TextFormField(
          //   onSaved: (newValue) => foodCategory = newValue!,
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return "Don't leave the field blank!";
          //     }
          //   },
          // decoration: const InputDecoration(
          //   labelText: "FoodCategory",
          //   labelStyle: TextStyle(
          //     color: Color(0xFFFF7643),
          //   ),
          //   hintText: "Enter your food category",
          //   floatingLabelBehavior: FloatingLabelBehavior.always,
          // ),
          // ),
        ),
      ],
    );
  }

  Column foodPriceField() {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        Container(
          child: TextFormField(
            inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: TextEditingController()..text = widget.menu.foodPrice.toString(),
            onSaved: (newValue) => price = double.parse(newValue!),
            validator: (value) {
              if (value!.isEmpty) {
                return "Don't leave the field blank!";
              } else {}
            },
            decoration: const InputDecoration(
              labelText: "FoodPrice",
              labelStyle: TextStyle(
                color: Color(0xFFFF7643),
              ),
              hintText: "Enter your price",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }

  Column foodPictureField(EditMenuViewModel viewodel) {
    return Column(
      children: [
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
              path = result.files.single.path!;
              pictureController.text = result.files.single.name;
            },
            controller: pictureController,
            onSaved: (newValue) {
              foodPicture = newValue!;
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
              labelText: "FoodPicture",
              labelStyle: TextStyle(
                color: Color(0xFFFF7643),
              ),
              hintText: "Insert your picture",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
