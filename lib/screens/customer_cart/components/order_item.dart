import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/screens/customer_cart/cart_view_model.dart';

class OrderItemCard extends StatelessWidget {
  String orderItemId;
  CartViewModel viewmodel;
  OrderItemCard(
      {super.key, required this.orderItemId, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Text(viewmodel.)
            ],
          )
        ],
      ),
    );
  }
}
