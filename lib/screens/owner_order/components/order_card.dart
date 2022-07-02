import 'package:flutter/material.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_viewmodel.dart';
import 'package:foodpanzu/screens/owner_view_order/owner_view_order_screen.dart';
import 'package:map_mvvm/map_mvvm.dart';

class OrderCard extends StatelessWidget {
  Order? order;

  OrderCard({
    super.key,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return View<OwnerOrderViewModel>(
      builder: (_, viewmodel) => Container(
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
        margin: const EdgeInsets.all(20),
        height: 150,
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
              left: 10,
              top: 0,
              //bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 45,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 5,
              //bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 90,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: FutureBuilder(
                      future: viewmodel.getName(order!.userId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return Text(
                            snapshot.data.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFF7643),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          );
                        }
                      }),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Text(
                    "Table No : ${order!.tableNumber}",
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
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: const TextStyle(
                            color: Color(0xFFFF7643),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Align(
                          child: Text(
                            order!.orderStatus,
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
              right: 0,
              top: 40,
              //bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 90,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Text(
                    order!.orderItems!.length.toString() + " items",
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
              right: 85,
              bottom: 0,
              //bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                    onTap: () {
                      viewmodel.setOrder(order!.orderId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OwnerViewOrder()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 115,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFFFF7643)),
                      child: Text(
                        "View Order",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
