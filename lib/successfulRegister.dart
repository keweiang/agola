import 'package:agola/creativeStage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SuccessfulRegister extends StatefulWidget {
  @override
  _SuccessfulRegisterState createState() => _SuccessfulRegisterState();
}

class _SuccessfulRegisterState extends State<SuccessfulRegister> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Background-Mobile Agola.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset(
                    'assets/scanSuccess.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  'SUCCESS!',
                  style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Colors.blue[200])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 55.0, left: 35.0, right: 35.0, bottom: 15.0),
                  child: Text(
                    'Please select one of the stages below:',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, top: 20.0, right: 50.0, bottom: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      elevation: 5,
                      color: Colors.yellow[700],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreativeStage()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'CREATIVE STAGE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, top: 20.0, right: 50.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      elevation: 5,
                      color: Colors.grey,
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Coming soon",
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[700]);
                      },
                      child: Container(
                        child: Text(
                          'LEARNING STAGE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
