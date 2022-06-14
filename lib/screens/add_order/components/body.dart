import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/screens/add_order/add_order_viewmodel.dart';
import 'package:foodpanzu/screens/add_order/components/menu_choosen_image.dart';
import 'package:foodpanzu/screens/add_order/components/review.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/view.dart';

class Body extends StatelessWidget {
  Menu menu;
  Body({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return View<AddOrderViewModel>(builder: (_, viewmodel) {
      return Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuImage(pictureUrl: viewmodel.getMenuImage(menu.foodPicture)),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.foodName.toTitleCase(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 57, 50, 45)),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  //review part for sprint 4
                  const Review(),
                  SizedBox(height: SizeConfig.screenHeight * 0.025),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          const Text(
                            "RM",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFF7643),
                            ),
                          ),
                          Text(
                            menu.foodPrice.toString(),
                            style: const TextStyle(
                              letterSpacing: -1,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF7643),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              height: SizeConfig.screenHeight * 0.04,
                              width: SizeConfig.screenWidth * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: const Color(0xFFFF7643),
                                    style: BorderStyle.solid),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 24,
                                color: Color(0xFFFF7643),
                              ),
                            ),
                            onTap: () {
                              // Function to remove quantity menu from the order item
                              // viewmodel.removeMenu(menu);
                            },
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "02",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              height: SizeConfig.screenHeight * 0.04,
                              width: SizeConfig.screenWidth * 0.1,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFF7643),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              //function to add order item to the order
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            Text(menu.foodDesc),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.055,
                width: SizeConfig.screenWidth * 0.35,
                decoration: BoxDecoration(
                    color: Color(0xFFFF7643),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10, left: 5),
                      height: SizeConfig.screenHeight * 0.038,
                      width: SizeConfig.screenWidth * 0.08,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Color(0xFFFF7643),
                        size: 18,
                      ),
                    ),
                    const Text(
                      "ADD TO CART",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
