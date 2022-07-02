import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:foodpanzu/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

final GlobalKey<_QrState> qrKey = GlobalKey();

class Qr extends StatefulWidget {
  String restId;
  Qr({super.key, required this.restId});

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // QrImage(
        //   data: widget.restId,
        //   version: 2,
        //   size: 200,
        // ),
        SizedBox(
          width: 130,
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.white,
              backgroundColor: kPrimaryColor,
            ),
            onPressed: generatePDF,
            child: const Text(
              'Download as PDF',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> generatePDF() async {
    var data = await rootBundle.load("assets/fonts/muli/Muli.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(font: myFont);
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.Text('QR Code', style: myStyle),
            pw.BarcodeWidget(width: 70, height: 70, barcode: pw.Barcode.qrCode(), data: widget.restId),
          ]));
        }));
    Directory directory = (await getApplicationDocumentsDirectory());

    String path = directory.path;

    File file = File('$path/output.pdf');

    await file.writeAsBytes(await pdf.save());

    OpenFile.open('$path/output.pdf');

  }
}
