import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/screens/customer_cart/cart_view_model.dart';
import 'package:foodpanzu/utils/size_config.dart';

class OrderItemCard extends StatelessWidget {
  CartViewModel viewmodel;
  OrderItemCard({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    if (viewmodel.hasOrder()) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:
            viewmodel.hasOrderItem() ? viewmodel.cart!.orderItems!.length : 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: ((context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FutureBuilder(
                      future: viewmodel.getMenuImage(index),
                      builder: (context, AsyncSnapshot<String> snapshot) {
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
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewmodel.menuList[index].foodName[0].toUpperCase() +
                            viewmodel.menuList[index].foodName.substring(1),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0005,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          viewmodel.menuList[index].foodDesc,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 129, 128, 128),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "RM${(viewmodel.menuList[index].foodPrice * viewmodel.orderItems![index].quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(0xFFFF7643),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Color(0xFFFF7643),
                      ),
                      onTap: () {
                        viewmodel.removeOrderItem(index);
                      },
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: SizeConfig.screenHeight * 0.04,
                            width: SizeConfig.screenWidth * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFFF7643),
                                  style: BorderStyle.solid),
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 24,
                              color: Color(0xFFFF7643),
                            ),
                          ),
                          onTap: () {
                            //function to minus quantity number
                            viewmodel.decreaseQuantity(index);
                          },
                        ),
                        const SizedBox(width: 10),
                        Text(
                          viewmodel.orderItems![index].quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          child: Container(
                            height: SizeConfig.screenHeight * 0.04,
                            width: SizeConfig.screenWidth * 0.1,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF7643),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            //function to add quantity number
                            viewmodel.increaseQuantity(index);
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }),
      );
    } else {
      return Text(
        textAlign: TextAlign.center,
        "No order made yet, go to menu to make order",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      );
    }
  }
}
