// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/cust_order/components/order_card.dart';
import 'package:foodpanzu/screens/cust_order/cust_order_viewmodel.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/view.dart';

class Body extends StatefulWidget {
  CustOrderViewModel viewmodel;
  Body({Key? key, required this.viewmodel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: Color(0xFFFF7643),
                          borderRadius: BorderRadius.circular(30)),
                      unselectedLabelColor:
                          Color(0xFFFF7643), // UnSelected Tab Color
                      labelColor: Colors.white, // Selected Tab Color
                      tabs: [
                        Tab(text: "Upcoming"),
                        Tab(
                          text: "History",
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: height - 295,
                child: TabBarView(children: [
                  // Upcoming tab

                  View<CustOrderViewModel>(
                      builder: (_, viewmodel) => RefreshIndicator(
                            onRefresh: () {
                              setState(() {
                                viewmodel.getOrder(widget.viewmodel.getId());
                              });
                              return Future<void>.delayed(
                                  const Duration(seconds: 1));
                            },
                            color: Colors.orange,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.viewmodel.hasOrder()
                                  ? widget.viewmodel.orderList.length
                                  : 1,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: ((_, index) {
                                if (widget.viewmodel.hasOrder()) {
                                  return OrderCard(
                                    menu: widget.viewmodel.orderList[index],
                                    onMenuClick: () {},
                                  );
                                } else
                                  // ignore: curly_braces_in_flow_control_structures
                                  return EmptyListWidget();
                              }),
                              physics: const AlwaysScrollableScrollPhysics(),
                            ),
                          )),

                  // History tab // not yet siap
                  View<CustOrderViewModel>(
                      builder: (_, viewmodel) {
                        return RefreshIndicator(
                            onRefresh: () {
                              setState(() {
                                viewmodel.getOrderHis(widget.viewmodel.getId());
                              });
                              return Future<void>.delayed(
                                  const Duration(seconds: 1));
                            },
                            color: Colors.orange,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.viewmodel.hasOrderHis()
                                  ? widget.viewmodel.orderHisList.length
                                  : 1,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: ((_, index) {
                                if (widget.viewmodel.hasOrderHis()) {
                                  return OrderCard(
                                    menu: widget.viewmodel.orderHisList[index],
                                    onMenuClick: () {},
                                  );
                                } else
                                  // ignore: curly_braces_in_flow_control_structures
                                  return EmptyListWidget();
                              }),
                              physics: const AlwaysScrollableScrollPhysics(),
                            ),
                          );
                      }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
