import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/owner_view_order/owner_view_order_viewmodel.dart';
import 'package:foodpanzu/widgets/food_category_icon.dart';
import 'package:intl/intl.dart';

class OrderCardView extends StatelessWidget {
  OwnerViewOrderViewModel viewmodel;
  OrderCardView({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    if (viewmodel.hasOrder()) {
      return FutureBuilder(
          future: viewmodel.set(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: viewmodel.hasOrderItems()
                    ? viewmodel.order.orderItems!.length
                    : 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        //color: Colors.white, //background color of box
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            7.0, // Move to right 10  horizontally
                            7.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 45,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              child: FoodCategoryIcon(
                                foodCategory:
                                    viewmodel.menuList[index].category,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 95,
                          top: 5,
                          //bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 100,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              child: Text(
                                viewmodel.menuList[index].foodName,
                                //viewmodel.getMenu(index),
                                style: const TextStyle(
                                  color: Color(0xFFFF7643),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 5,
                          //bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 90,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              child: Text(
                                "Quantity: " +
                                    viewmodel.orderItems[index].quantity
                                        .toString(),
                                style: const TextStyle(
                                  color: Color(0xFFFF7643),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 95,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: const TextStyle(
                                        color: Color(0xFFFF7643),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Align(
                                      child: Text(
                                        "RM " +
                                            viewmodel.menuList[index].foodPrice
                                                .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 0,
                          //bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FutureBuilder(
                                  future: viewmodel.getMenuImage(index),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        !snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.fill,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }
          });
    } else {
      return Text(
        textAlign: TextAlign.center,
        "No record",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      );
    }
  }
}
