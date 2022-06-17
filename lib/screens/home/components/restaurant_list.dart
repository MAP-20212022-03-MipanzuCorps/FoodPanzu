import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return View<HomeViewModel>(
      builder: (_, viewmodel) => Container(
        height: 500,
        child: RefreshIndicator(
          onRefresh: () {
            viewmodel.getRestaurantList();
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
            itemCount: viewmodel.restaurantList!.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: GestureDetector(
                onTap: () {
                  viewmodel
                      .setRestaurant(viewmodel.restaurantList![index].restId);
                  Navigator.pushNamed(context, RestaurantMenuScreen.routeName);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(2)),
                    height: 100,
                    width: double.infinity,
                    child:
                        Text('${viewmodel.restaurantList![index].restName}')),
              ),
            ),
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
