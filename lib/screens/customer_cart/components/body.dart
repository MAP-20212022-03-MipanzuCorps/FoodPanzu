import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/customer_cart/cart_view_model.dart';
import 'package:foodpanzu/screens/customer_cart/components/order_item.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return View<CartViewModel>(builder: (_, viewmodel) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        width: SizeConfig.screenWidth,
        color: Colors.orange,
        child: Column(
          children: [
            if (viewmodel.hasOrder())
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: viewmodel.hasOrderItem()
                    ? viewmodel.cart!.orderItems!.length
                    : 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: ((context, index) {
                  return OrderItemCard(
                      orderItemId: viewmodel.cart!.orderItems![0],
                      viewmodel: viewmodel);
                }),
              ),
            // OrderItemCard(orderItemId: viewmodel.cart!.orderItems![0], viewmodel: viewmodel),
          ],
        ),
      );
    });
  }
}
