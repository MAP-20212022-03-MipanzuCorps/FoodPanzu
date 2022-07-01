// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/owner_dashboard/dashboard_viewmodel.dart';
import 'package:foodpanzu/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:month_year_picker/month_year_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:qr_flutter/qr_flutter.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: View<DashboardViewModel>(builder: (_, viewmodel) {
        return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: FutureBuilder(
                future: viewmodel.getRestaurant(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              viewmodel.restName,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Container(
                                width: 300,
                                height: 75,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                      SizedBox(
                                        width: 20,
                                      ),
                                      CupertinoSwitch(
                                          value: viewmodel.getStatus,
                                          activeColor: kPrimaryColor,
                                          onChanged: (value) {
                                            viewmodel.openClose();
                                            viewmodel.restStatus = value;
                                          }),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        viewmodel.getStats,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text('QR Code of Restaurant',
                                style: TextStyle(fontSize: 20)),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(3, 5))
                                  ]),
                              width: 270,
                              height: 270,
                              child: Column(
                                children: [
                                  QrImage(
                                    data: viewmodel.restId,
                                    version: 2,
                                    size: 200,
                                  ),
                                  SizedBox(
                                    width: 130,
                                    height: 40,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        primary: Colors.white,
                                        backgroundColor: kPrimaryColor,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Download as PDF',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(3, 5))
                                    ]),
                                width: 270,
                                height: 270,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Monthly Sales'),
                                    if (_selected == null)
                                      const Text('No month year selected.')
                                    else
                                      SizedBox(
                                        width: 130,
                                        height: 40,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            primary: Colors.white,
                                            backgroundColor: kPrimaryColor,
                                          ),
                                          onPressed: () =>
                                              _onPressed(context: context),
                                          child: Text(
                                            DateFormat()
                                                .add_yM()
                                                .format(_selected!),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  }
                }));
      }),
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
  }) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2023),
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
