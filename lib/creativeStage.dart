import 'package:agola/manualConfigure.dart';
import 'package:agola/myAccController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CreativeStage extends StatefulWidget {
  @override
  _CreativeStageState createState() => _CreativeStageState();
}

class _CreativeStageState extends State<CreativeStage> {
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 38.0),
                  child: Text(
                    'You have selected: ',
                    style: GoogleFonts.dosis(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, top: 35.0, bottom: 65.0, right: 25.0),
                    child: Text(
                      "CREATIVE\n STAGE",
                      style: GoogleFonts.dosis(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 35,
                            color: Colors.lightBlue[300]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Center(
                    child: Text(
                      "Please select the controller function below\n to proceed: ",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
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
                              builder: (context) => Myacccontroller()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'AUTO',
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
                      color: Colors.yellow[700],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManualConfigure()),
                        );
                      },
                      child: Container(
                        child: Text(
                          'MANUAL',
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
