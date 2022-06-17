import 'package:flutter/material.dart';
import 'package:foodpanzu/components/cust_navbar.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/body.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'restaurantmenu_viewmodel.dart';

class RestaurantMenuScreen extends StatelessWidget {
  static String routeName = "/restaurantmenu";
  RestaurantMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: View<RestaurantMenuViewModel>(
        builder: (_, viewmodel) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: true,
              collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/pizza.png"),
                          fit: BoxFit.cover,
                          alignment: Alignment.centerLeft),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${viewmodel.restaurant.restName}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 47, 44, 44),
                        ),
                      ),
                      Text(
                        '${viewmodel.restaurant.restDesc}',
                        style: const TextStyle(color: Color(0xFFFF7643)),
                      ),
                    ],
                  )),
              leading: AppBar(),
            ),
            Body(),
          ],
        ),
      ),
      bottomNavigationBar: const CustBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
