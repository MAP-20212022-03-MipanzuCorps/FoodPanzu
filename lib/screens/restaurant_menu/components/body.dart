import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/restaurant_menu/components/restaurant_menulist.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';
// import 'restaurant_menulist.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
          View<RestaurantMenuViewModel>(
            builder: (_, viewmodel) =>
                RefreshIndicator(
              onRefresh: () {

                viewmodel.getRestaurantMenu();
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: FutureBuilder(
                  future: viewmodel.getRestaurantMenu(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (viewmodel.hasMenu()) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: viewmodel.menuList.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: ((context, index) {
                              return MenuListCard(
                                menu: viewmodel.menuList[index],
                                onMenuClick: () {},
                                downloadUrl: viewmodel.getMenuImage(
                                    viewmodel.menuList[index].foodPicture),
                              );
                            }));
                      } else {
                        return  const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child:
                                Text('There is no menu found in this restaurant'),
                          ),
                        );
                      }
                    }
                  }),
            ),
          )
        ],
      ),
    );
  
  }
}
