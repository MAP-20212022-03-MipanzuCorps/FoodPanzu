import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/customer_cart/cart_view_model.dart';
import 'package:foodpanzu/screens/customer_cart/components/order_item.dart';
import 'package:foodpanzu/screens/customer_cart/components/payment_success.dart';
import 'package:foodpanzu/utils/size_config.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController tableNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return View<CartViewModel>(
      builder: (_, viewmodel) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                OrderItemCard(viewmodel: viewmodel),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    TextFormField(
                      controller: tableNumber,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF7643),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 217, 217, 217),
                            width: 1.0,
                          ),
                        ),
                        hintText: "Enter your table number",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 185, 184, 184),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7643),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Text(
                          "Apply",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (viewmodel.hasOrder()) {
                          viewmodel.applyTableNumber(tableNumber.text);
                        } else {
                          const snackbar = SnackBar(
                            content: Text('Please add item in the cart'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 217, 217, 217)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Subtotal",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "RM${viewmodel.cart != null ? viewmodel.getSubTotalItem().toStringAsFixed(2) : "0.00"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 217, 217, 217)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tax and Fees",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "RM${viewmodel.cart != null ? (viewmodel.cart!.totalPrice - viewmodel.getSubTotalItem()).toStringAsFixed(2) : "0.00"}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 217, 217, 217)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.01,
                            ),
                            Text(
                              "(${viewmodel.hasOrderItem() ? viewmodel.cart!.orderItems!.length.toString() : "0"} items )",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 167, 166, 166),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "RM${viewmodel.cart != null ? viewmodel.cart!.totalPrice.toStringAsFixed(2) : 0.00}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Column(
                  children: [
                    InkWell(
                      child: Container(
                        width: 140,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7643),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Text(
                          "Pay At Counter",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        //Change order/cart status to cooking
                        if (viewmodel.hasOrder()) {
                          viewmodel.changeOrderStatus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSucess(),
                            ),
                          );
                        } else {
                          const snackbar = SnackBar(
                            content: Text('Please add item in the cart'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    const Text("Or"),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 140,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7643),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Text(
                          "Pay Online",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        //Change order/cart status to cooking
                        if (viewmodel.hasOrder()) {
                          viewmodel.changeOrderStatus();
                          MaterialPageRoute(
                            builder: (context) => const PaymentSucess(),
                          );
                        } else {
                          const snackbar = SnackBar(
                            content: Text('Please add item in the cart'),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    tableNumber.dispose();
    super.dispose();
  }
}
