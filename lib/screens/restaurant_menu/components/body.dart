import 'package:flutter/material.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:map_mvvm/map_mvvm.dart';
// import 'restaurant_menulist.dart';

class Body extends StatefulWidget {
  Body({super.key});
  // Body({super.key, this.restaurant});

  Restaurant? restaurant;
  
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return View<RestaurantMenuViewModel>(builder: (_, viewmodel) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: RefreshIndicator(
                onRefresh: () {
                  // setState(() {
                  viewmodel.getRestaurantMenu();
                  print(viewmodel.menuList.length);
                  // });
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: viewmodel.menuList.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(2)),
                          height: 100,
                          width: double.infinity,
                          child: Text(viewmodel.menuList[index].foodName)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
