import 'package:agola/creativeStage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agola/manualController.dart';

class ManualConfigure extends StatefulWidget {
  @override
  _ManualConfigureState createState() => _ManualConfigureState();
}

class _ManualConfigureState extends State<ManualConfigure> {
  // int dropdownValue = 1;
  // int dropdownValue2 = 2;
  // int dropdownValue3 = 3;
  // int dropdownValue4 = 4;
  // int dropdownValue5 = 5;
  // int dropdownValue6 = 6;
  // int dropdownValue7 = 7;
  // int dropdownValue8 = 8;
  // List<int> dropDowns = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  List<int> dropDownArrow = [1, 2, 3, 4];
  List<int> dropDownAction = [5, 6, 7, 8];

  List<int> validNumber = [1, 2, 3, 4, 5, 6, 7, 8];

  List<int> selectedValue = [0, 0, 0, 0, 0, 0, 0, 0];

  bool enable = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFF),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              Color(0xFFFFFF00);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreativeStage()));
            });
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          "Configure Buttons",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Background-Mobile Agola.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/black_down.jpg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedValue[0] == 0
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                )
                              : Text(selectedValue[0].toString()),
                          DropdownButton<int>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (newValue) {
                              setState(() {
                                if (validNumber.contains(selectedValue[0])) {
                                  dropDownArrow.add(selectedValue[0]);
                                }
                                selectedValue[0] = newValue;
                                dropDownArrow.remove(newValue);
                              });
                            },
                            items: dropDownArrow
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: CustomText(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0, right: 10.0),
                      child: Column(
                        children: [
                          Text(
                            "Reminder",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red),
                          ),
                          Text("\n1 = Move Backwards\n\n2 = Turn Left",
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/black_left.jpg',
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Container(
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent,
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedValue[1] == 0
                                  ? Text(
                                      "-",
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(selectedValue[1].toString()),
                              DropdownButton<int>(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (validNumber
                                        .contains(selectedValue[1])) {
                                      dropDownArrow.add(selectedValue[1]);
                                    }
                                    selectedValue[1] = newValue;
                                    dropDownArrow.remove(newValue);
                                  });
                                },
                                items: dropDownArrow // NO 4
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: CustomText(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 70.0, right: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "3 = Move Forwards\n\n4 = Turn Right",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/black_up.jpg',
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Container(
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent,
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedValue[2] == 0
                                  ? Text(
                                      "-",
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(selectedValue[2].toString()),
                              DropdownButton<int>(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (validNumber
                                        .contains(selectedValue[2])) {
                                      dropDownArrow.add(selectedValue[2]);
                                    }
                                    selectedValue[2] = newValue;
                                    dropDownArrow.remove(newValue);
                                  });
                                },
                                items: dropDownArrow
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                      value: value,
                                      child: CustomText(
                                        value,
                                      ));
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 70.0, right: 10.0),
                          child: Column(
                            children: [
                              Text("5 = Move Both Arms\n\n6 = Move Left Arm",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/black_right.jpg',
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Container(
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: Colors.deepPurpleAccent,
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectedValue[3] == 0
                                  ? Text(
                                      "-",
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(selectedValue[3].toString()),
                              DropdownButton<int>(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (validNumber
                                        .contains(selectedValue[3])) {
                                      dropDownArrow.add(selectedValue[3]);
                                    }
                                    selectedValue[3] = newValue;
                                    dropDownArrow.remove(newValue);
                                  });
                                },
                                items: dropDownArrow
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: CustomText(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 70.0, right: 10.0),
                          child: Column(
                            children: [
                              Text("7 = Turn Head\n\n8 = Move Right Arm",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/yellow_down.jpg",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedValue[4] == 0
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                )
                              : Text(selectedValue[4].toString()),
                          DropdownButton<int>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (newValue) {
                              setState(() {
                                if (validNumber.contains(selectedValue[4])) {
                                  dropDownAction.add(selectedValue[4]);
                                }
                                selectedValue[4] = newValue;
                                dropDownAction.remove(newValue);
                              });
                            },
                            items: dropDownAction
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: CustomText(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/red_left.jpg",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedValue[5] == 0
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                )
                              : Text(selectedValue[5].toString()),
                          DropdownButton<int>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (newValue) {
                              setState(() {
                                if (validNumber.contains(selectedValue[5])) {
                                  dropDownAction.add(selectedValue[5]);
                                }
                                selectedValue[5] = newValue;
                                dropDownAction.remove(newValue);
                              });
                            },
                            items: dropDownAction
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: CustomText(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/blue_up.jpg",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedValue[6] == 0
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                )
                              : Text(selectedValue[6].toString()),
                          DropdownButton<int>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (newValue) {
                              setState(() {
                                if (validNumber.contains(selectedValue[6])) {
                                  dropDownAction.add(selectedValue[6]);
                                }
                                selectedValue[6] = newValue;
                                dropDownAction.remove(newValue);
                              });
                            },
                            items: dropDownAction
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: CustomText(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/green_right.jpg",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedValue[7] == 0
                              ? Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  selectedValue[7].toString(),
                                ),
                          DropdownButton<int>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (newValue) {
                              setState(() {
                                if (validNumber.contains(selectedValue[7])) {
                                  dropDownAction.add(selectedValue[7]);
                                }
                                selectedValue[7] = newValue;
                                dropDownAction.remove(newValue);
                              });
                            },
                            items: dropDownAction
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: CustomText(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            dropDownArrow = [1, 2, 3, 4];
                            dropDownAction = [5, 6, 7, 8];

                            validNumber = [1, 2, 3, 4, 5, 6, 7, 8];

                            selectedValue = [0, 0, 0, 0, 0, 0, 0, 0];
                          });
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 5,
                        color: Colors.yellow[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: RaisedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Data saved",
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey[700]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManualController(
                                      dropdownValue: this.selectedValue[0],
                                      dropdownValue2: this.selectedValue[1],
                                      dropdownValue3: this.selectedValue[2],
                                      dropdownValue4: this.selectedValue[3],
                                      dropdownValue5: this.selectedValue[4],
                                      dropdownValue6: this.selectedValue[5],
                                      dropdownValue7: this.selectedValue[6],
                                      dropdownValue8: this.selectedValue[7])));
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 5,
                        color: Colors.yellow[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final int val;
  final bool isDisabled;

  CustomText(this.val, {this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        val.toString(),
        style: TextStyle(
            color: isDisabled
                ? Theme.of(context).unselectedWidgetColor
                // ignore: deprecated_member_use
                : Theme.of(context).textTheme.title.color),
      ),
      onTap: isDisabled ? () {} : null,
    );
  }
}
