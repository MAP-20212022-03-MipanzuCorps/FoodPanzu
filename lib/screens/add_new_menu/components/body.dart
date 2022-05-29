import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/screens/add_new_menu/add_new_menu_viewmodel.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:map_mvvm/view.dart';

import '../../../utils/constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

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
    return View<AddNewMenuViewModel>(
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
                            viewmodel.addNewMenu(
                                Menu(
                                    category: foodCategory!,
                                    foodDesc: foodDescription,
                                    foodPrice: price,
                                    foodName: foodName,
                                    foodPicture: foodPicture),
                                path);
                            Navigator.pop(context);
                          }),
                          child: Text(
                            "Save",
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
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onSaved: (newValue) => price = double.parse(newValue!),
            validator: (value) {
              if (value!.isEmpty) {
                return "Don't leave the field blank!";
              }
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

  Column foodPictureField(AddNewMenuViewModel viewodel) {
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
}
