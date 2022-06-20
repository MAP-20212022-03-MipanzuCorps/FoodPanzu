import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/screens/cust_view_order/components/order_card.dart';
import 'package:foodpanzu/screens/cust_view_order/cust_view_order_viewmodel.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return View<CustViewOrderViewModel>(
        builder: (_, viewmodel) {
          return SingleChildScrollView(
            child: Column(
            children: [
              OrderCardView(viewmodel: viewmodel),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                   primary: Color(0xFFFF7643)
                   ),
                  child: Text("Go Back"),
          
                ),
              ),
            ],
                  ),
          );
        }
    );
  }
}
