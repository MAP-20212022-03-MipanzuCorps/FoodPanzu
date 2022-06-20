// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:foodpanzu/widgets/food_category_icon.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SmallMenuCard extends StatelessWidget {
  Menu menu;
  SmallMenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(150),
        child: View<HomeViewModel>(builder: (_, viewmodel) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                FutureBuilder(
                    future: viewmodel.getMenuImage(menu.foodPicture),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return CircularProgressIndicator();
                      } else {
                        return Image.network(
                          snapshot.data as String,
                          fit: BoxFit.cover,
                        );
                      }
                    }),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 46, 46, 46).withOpacity(0.3),
                        Color.fromARGB(255, 121, 121, 121).withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      menu.foodName,
                      style: TextStyle(color: Colors.white),
                    )),
                Positioned(
                    top: 10,
                    left: 10,
                    child: Row(
                      children: [
                        Text(
                          'RM',
                          style: TextStyle(color: kPrimaryLightColor),
                        ),
                        Text(
                          menu.foodPrice.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
