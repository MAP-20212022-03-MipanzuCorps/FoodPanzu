import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/header.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/restaurant_menulist.dart';
import 'package:foodpanzu/screens/add_order/add_order_screen.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return View<RestaurantMenuViewModel>(
        builder: (_, viewmodel) => RefreshIndicator(
            displacement: 100,
            color: kPrimaryColor,
            onRefresh: () {
              viewmodel.getRestaurantMenu();
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(slivers: [
              Header(),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: const Text("Sort by: "),
                      ),
                      const Text(
                        "Category",
                        style: TextStyle(color: Color(0xFFFF7643)),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future: viewmodel.getRestaurantMenu(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (viewmodel.hasMenu()) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: viewmodel.menuList.length,
                              (BuildContext context, int index) {
                            return MenuListCard(
                              menu: viewmodel.menuList[index],
                              onMenuClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddOrderScreen(
                                      menu: viewmodel.menuList[index],
                                    ),
                                  ),
                                );
                              },
                              downloadUrl: viewmodel.getMenuImage(
                                  viewmodel.menuList[index].foodPicture),
                            );
                          }),
                        );
                      } else {
                        return SliverToBoxAdapter(child: EmptyListWidget());
                      }
                    }
                  }),
            ])));
  }
}
