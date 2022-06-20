import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/customer_cart/cart.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/widgets/cart_button.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                  title: View<RestaurantMenuViewModel>(
                    builder: (_,viewmodel) {
                      return Column(
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
                      );
                    }
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 8.0),
                  child: CartButton(
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
              }),
                ),
              ],
            );
    
  }
}