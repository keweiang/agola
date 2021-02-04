import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'successfulRegister.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String scanResult = '';

//function that launches the scanner
  Future scanQRCode() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    String cameraScanResult = await BarcodeScanner.scan();
    setState(() {
      scanResult = cameraScanResult;
    });

    if (scanResult == 'Agola') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessfulRegister()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Background-Mobile Agola.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 0.0, right: 0.0, bottom: 0.0),
                  child: Text(
                    'Hello,\n',
                    style: GoogleFonts.dosis(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 0.0, right: 0.0, bottom: 0.0),
                  child: Text(
                    "WELCOME",
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 30)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.asset('assets/scanQR.png',
                        height: 150, width: 150),
                  ),
                ),
                Center(
                  child: Text(
                    'Please click to scan QR code',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                scanResult == ''
                    ? Text('Result will be displayed here',
                        style: TextStyle(color: Colors.grey[50]))
                    : Text('(' + scanResult + ')'),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 15.0, right: 25.0, bottom: 0.0),
                      child: SizedBox(
                        width: 270,
                        height: 50,
                        child: RaisedButton(
                          elevation: 5,
                          color: Colors.yellow[700],
                          child: Text(
                            'Scan QR code',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: scanQRCode,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
