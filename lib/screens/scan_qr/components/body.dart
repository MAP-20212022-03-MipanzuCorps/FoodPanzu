import 'package:flutter/material.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_screen.dart';
import 'package:foodpanzu/screens/scan_qr/scan_qr_screen.dart';
import 'package:foodpanzu/screens/scan_qr/scan_qr_viewmodel.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String qrCodeResult = "Restaurant's QR Code";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Message displayed over here
          Text(
            "Please Scan",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            qrCodeResult,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),

          View<ScanQRViewModel>(
            builder: (_, viewmodel) {
              return InkWell(
                  onTap: () async {
                    String? codeSanner;
                    if (await Permission.camera.request().isGranted) {
                      // Either the permission was already granted before or the user just granted it.
                      codeSanner = await scanner.scan(); //barcode scanner
                    }else{
                      Navigator.pop(context);
                    }
                    viewmodel.setRestaurant(codeSanner);
                    Navigator.pushNamed(
                        context, RestaurantMenuScreen.routeName);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 115,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFFF7643)),
                    child: Text(
                      "Open Camera",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
