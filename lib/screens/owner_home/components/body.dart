import 'package:flutter/material.dart';
import 'package:foodpanzu/components/default_button.dart';
import 'package:foodpanzu/screens/menu_details/menu_details_screen.dart';
import 'package:foodpanzu/screens/owner_home/menu_cart_viewmodel.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_viewmodel.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:foodpanzu/screens/owner_home/components/menu_cart.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../../widgets/food_category_icon.dart';
import '../../add_new_menu/add_new_menu_screen.dart';

class Body extends StatelessWidget {
  OwnerHomeViewModel viewmodel;

  Body({Key? key, required this.viewmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
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
          InkWell(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey,
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: const Color.fromARGB(255, 79, 78, 78),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Text(
                    "Add Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AddNewMenuScreen.routeName);
            },
          ),
          View<MenuListViewModel>(builder: (_, viewmodel) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewmodel.hasMenu() ? viewmodel.menuList!.length : 0,
              shrinkWrap: true,
              primary: false,
              itemBuilder: ((context, index) {
                return MenuCard(
                    menu: viewmodel.menuList?[index],
                    onMenuClick: () {
                      Navigator.pushNamed(context, MenuDetailScreen.routeName);
                    },
                    viewmodel: viewmodel);
              }),
            );
          })
        ],
      ),
    );
  }
}
