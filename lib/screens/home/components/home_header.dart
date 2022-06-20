import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/customer_Cart/cart.dart';
import 'package:foodpanzu/utils/constants.dart';
import '../../../widgets/cart_button.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
              backgroundColor: kPrimaryLightColor,
              expandedHeight: 200,
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/bg.png",
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromARGB(60, 255, 236, 223), Color.fromARGB(226, 255, 217, 174)])),
                  ),
                ]),
                centerTitle: true,
                title: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Where would you like to eat?',
                    style: TextStyle(
                      // fontSize: 20,
                      color: Color.fromARGB(255, 47, 44, 44),
                    ),
                  ),
                ),
              ),
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
