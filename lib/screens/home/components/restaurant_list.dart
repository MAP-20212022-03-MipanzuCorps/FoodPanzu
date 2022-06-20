import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/map_mvvm.dart';

import 'restaurant_card.dart';

class RestaurantList extends StatefulWidget {
  int numOfRest;
  Axis axis;
  RestaurantList({super.key, required this.numOfRest, required this.axis});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    return View<HomeViewModel>(
        builder: (_, viewmodel) => FutureBuilder(
            future: viewmodel.getRestaurantList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (viewmodel.hasRestaurant()) {
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: widget.axis,
                      itemCount: widget.numOfRest,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: GestureDetector(
                          onTap: () {
                            viewmodel.setRestaurant(
                                viewmodel.restaurantList![index].restId);
                            Navigator.pushNamed(
                                context, RestaurantMenuScreen.routeName);
                          },
                          child: RestaurantCard(restaurant: viewmodel.restaurantList![index], width: getProportionateScreenWidth(200), height: 100,),
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
