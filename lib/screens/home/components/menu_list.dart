import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/map_mvvm.dart';

import 'small_menucard.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return View<HomeViewModel>(
        builder: (_, viewmodel) => FutureBuilder(
            future: viewmodel.getMenuList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (viewmodel.hasMenu()) {
                  return SizedBox(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: viewmodel.menuList.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: GestureDetector(
                          onTap: () {
                            viewmodel.setRestaurant(
                                viewmodel.menuList[index].restId);
                            Navigator.pushNamed(
                                context, RestaurantMenuScreen.routeName);
                          },
                          child: SmallMenuCard(menu: viewmodel.menuList[index]),
                        ),
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                  );
                } else {
                  return EmptyListWidget();
                }
              }
            }));
          
  }
}