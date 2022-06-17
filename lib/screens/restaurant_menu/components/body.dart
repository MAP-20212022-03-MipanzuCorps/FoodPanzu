import 'package:flutter/material.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/add_order/add_order_screen.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:map_mvvm/map_mvvm.dart';
// import 'restaurant_menulist.dart';

class Body extends StatefulWidget {
  // Body({super.key, required this.restaurant, required this.menuList});
  // Restaurant restaurant;
  // Future<List<Menu>> menuList;
  Body({super.key});
  // Body({super.key, this.restaurant});

  Restaurant? restaurant;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return View<RestaurantMenuViewModel>(builder: (_, viewmodel) {
      // return RefreshIndicator(
      //   onRefresh: () {
      //     // setState(() {
      //     viewmodel.getRestaurantMenu(widget.restaurant.restId);
      //     // });
      //     return Future<void>.delayed(const Duration(seconds: 1));
      //   },
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      // FutureBuilder<List<Menu>>(
      //   future: widget.menuList,
      //   builder: (
      //     BuildContext context,
      //     AsyncSnapshot<List<Menu>> snapshot,
      //   ) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const CircularProgressIndicator();
      //     } else if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasError) {
      //         return const Text('Error');
      //       } else if (snapshot.hasData) {
      //         return Container(
      //           height: 500,
      //           child: ListView.builder(
      //             itemCount: snapshot.data!.length,
      //             itemBuilder: (_, index) => Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 20, vertical: 15),
      //               child: GestureDetector(
      //                 onTap: () {},
      //                 child: Container(
      //                     decoration: BoxDecoration(
      //                         color: kPrimaryColor,
      //                         borderRadius: BorderRadius.circular(2)),
      //                     height: 100,
      //                     width: double.infinity,
      //                     child: Text(snapshot.data![index].foodName)),
      //               ),
      //             ),
      //           ),
      //         );
      //       } else {
      //         return const Text('Empty data');
      //       }
      //     } else {
      //       return Text('State: ${snapshot.connectionState}');
      //     }
      //   },
      // ),
      //         if (viewmodel.hasMenu(widget.restaurant.restId))
      //           Container(
      //             height: 500,
      //             child: ListView.builder(
      //               itemCount: viewmodel.menuList.length,
      //               itemBuilder: (_, index) => Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                     horizontal: 20, vertical: 15),
      //                 child: GestureDetector(
      //                   onTap: () {},
      //                   child: Container(
      //                       decoration: BoxDecoration(
      //                           color: kPrimaryColor,
      //                           borderRadius: BorderRadius.circular(2)),
      //                       height: 100,
      //                       width: double.infinity,
      //                       child: Text(viewmodel.menuList[index].foodName)),
      //                 ),
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: RefreshIndicator(
                onRefresh: () {
                  // setState(() {
                  viewmodel.getRestaurantMenu();
                  print(viewmodel.menuList.length);
                  // });
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: viewmodel.menuList.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOrderScreen(
                              menu: viewmodel.menuList[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(2)),
                          height: 100,
                          width: double.infinity,
                          child: Text(viewmodel.menuList[index].foodName)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
