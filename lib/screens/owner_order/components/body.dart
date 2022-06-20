// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/owner_order/components/order_card.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_viewmodel.dart';
import 'package:foodpanzu/widgets/emptyWidget.dart';
import 'package:map_mvvm/view.dart';

class Body extends StatefulWidget {
  OwnerOrderViewModel viewmodel;
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

                  View<OwnerOrderViewModel>(builder: (_, viewmodel) {
                    return RefreshIndicator(
                      onRefresh: () {
                        setState(() {
                          viewmodel.getOrder(widget.viewmodel.getRes());
                        });
                        return Future<void>.delayed(const Duration(seconds: 1));
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
                              order: widget.viewmodel.orderList[index],
                            );
                          } else
                            // ignore: curly_braces_in_flow_control_structures
                            return EmptyListWidget();
                        }),
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
                    );
                  }),

                  // History tab
                  View<OwnerOrderViewModel>(builder: (_, viewmodel) {
                    return RefreshIndicator(
                      onRefresh: () {
                        setState(() {
                          viewmodel.getOrderHis(widget.viewmodel.getRes());
                        });
                        return Future<void>.delayed(const Duration(seconds: 1));
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
                              order: widget.viewmodel.orderHisList[index],
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
