import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/customer_cart/cart.dart';
import 'package:foodpanzu/screens/home/components/home_header.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/widgets/cart_button.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'menu_list.dart';
import 'restaurant_card.dart';
import 'restaurant_list.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<HomeViewModel>(
        builder: (_, viewmodel) => RefreshIndicator(
              displacement: 100,
              color: kPrimaryColor,
              onRefresh: () {
                viewmodel.refreshPage();
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: CustomScrollView(
                slivers: [
                  HomeHeader(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 25, top: 17),
                          child: const Text(
                            "Featured Restaurants",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        RestaurantList(numOfRest: 4, axis: Axis.horizontal),
                        Container(
                          margin: const EdgeInsets.only(left: 25, top: 17),
                          child: const Text(
                            "Featured Foods",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        MenuList(),
                        Container(
                          margin: const EdgeInsets.only(left: 25, top: 17),
                          child: const Text(
                            "All Restaurants",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: viewmodel.restaurantList!.length,
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: GestureDetector(
                          onTap: () {
                            viewmodel.setRestaurant(
                                viewmodel.restaurantList![index].restId);
                            Navigator.pushNamed(
                                context, RestaurantMenuScreen.routeName);
                          },
                          child: RestaurantCard(
                            restaurant: viewmodel.restaurantList![index],
                            width: 200,
                            height: 200,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ));
  }
}
