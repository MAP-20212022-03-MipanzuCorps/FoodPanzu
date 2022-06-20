// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;
  double width, height;
  RestaurantCard({super.key, required this.restaurant, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: View<HomeViewModel>(builder: (_, viewmodel) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              FutureBuilder(
                  future:
                      viewmodel.getRestaurantPicture(restaurant.restPicture),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.data == null) {
                        return Center(
                          child: Image.asset(
                            "assets/images/restPic default.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Center(
                          child: Image.network(
                            snapshot.data as String,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }
                  }),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 46, 46, 46).withOpacity(0.5),
                      Color.fromARGB(255, 121, 121, 121).withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      restaurant.restName,
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
