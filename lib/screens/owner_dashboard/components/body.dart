// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/owner_dashboard/dashboard_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:map_mvvm/map_mvvm.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: View<DashboardViewModel>(builder: (_, viewmodel) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${viewmodel.restaurant.restName}',
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 300,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(3, 5))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Restaurant Status :',
                            style: TextStyle(color: Colors.black),
                          ),
                          CupertinoSwitch(
                              value: viewmodel.getStatus,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                setState(() {
                                  viewmodel.openClose();
                                  viewmodel.restStatus = value;
                                });
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            viewmodel.getStats,
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
