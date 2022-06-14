import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
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
            setState(() {
              viewmodel.getRestaurantList();
            });
            return Future<void>.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
            itemCount: viewmodel.restaurantList!.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal:20, vertical: 15),
              child: GestureDetector(
                onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantMenuScreen(restaurant: viewmodel.restaurantList![index]))),
                child: Container(
                  decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(2)),              
                    height: 100,
                    width: double.infinity,
                    child: Text('${viewmodel.restaurantList![index].restName}')),
              ),
            ),
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
