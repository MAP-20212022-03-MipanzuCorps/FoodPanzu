import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'home_header.dart';
import 'restaurant_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: View<HomeViewModel>(
          builder: (_,viewmodel) {
            return Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Where would you like to eat?', style: TextStyle(color: Colors.black, fontSize: 30,),),
                ),
                Text('Restaurants list', style: TextStyle(color: Colors.black, fontSize: 20,),),
                
                RestaurantList(),

              ],
            );
          }
        ),
      ),
    );
  }
}
