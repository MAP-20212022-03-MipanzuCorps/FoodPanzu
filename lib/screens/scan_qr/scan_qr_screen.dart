//import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:foodpanzu/components/cust_navbar.dart';
import 'package:foodpanzu/screens/scan_qr/components/body.dart';
import 'package:foodpanzu/utils/enums.dart';



class ScanQR extends StatefulWidget {
  static String routeName = "/scan_qr";
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Scan QR",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustBottomNavBar(selectedMenu: MenuState.qrcode),
    );
  }
}
