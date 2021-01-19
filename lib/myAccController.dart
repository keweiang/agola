// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:convert';

import 'package:agola/creativeStage.dart';
import 'package:agola/models/gestures.dart';
import 'package:agola/models/pad_button_item.dart';
import 'package:agola/views/pad_button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Myacccontroller extends StatelessWidget {
  Myacccontroller();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JoyPad(),
      theme: ThemeData.light(),
    );
  }
}

// ignore: must_be_immutable
class JoyPad extends StatefulWidget {
  JoyPad();
  @override
  _JoyPadState createState() => _JoyPadState();
}

class _JoyPadState extends State<JoyPad> {
  _JoyPadState();

  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Initializing a global key, as it would help us in showing a SnackBar later
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  // ignore: unused_field
  int _deviceState;

  bool isDisconnecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    super.initState();
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; //neutral

    enableBluetooth();

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    PadButtonPressedCallback padButtonPressedCallback(
        int buttonIndex, Gestures gesture) {
      String data = "buttonIndex: $buttonIndex";
      print("Print Data: " + data);

      connection.output.add(utf8.encode("$buttonIndex"));
      connection.output.allSent;
      setState(() {
        _deviceState = buttonIndex;
      });
    }

    return Scaffold(
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bluetooth, color: Colors.black),
            onPressed: () {
              FlutterBluetoothSerial.instance.openSettings();
            },
          ),
          FlatButton.icon(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            label: Text(
              "Refresh",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            splashColor: Colors.deepPurple,
            onPressed: () async {
              // So, that when new devices are paired
              // while the app is running, user can refresh
              // the paired devices list.
              await getPairedDevices();
              // .then((_) {
              // show('Device list refreshed');
              // }
              // );
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                visible: _isButtonUnavailable &&
                    _bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 4.0, right: 15.0, bottom: 0.0),
                            child: Text(
                              'Paired Devices:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DropdownButton(
                            hint: Text("Paired Devices"),
                            items: _getDeviceItems(),
                            onChanged: (value) =>
                                setState(() => _device = value),
                            value: _devicesList.isNotEmpty ? _device : null,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 260.0, right: 10.0),
                            child: RaisedButton(
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected
                                      ? _disconnect
                                      : _connect,
                              child:
                                  Text(_connected ? 'Disconnect' : 'Connect'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PadButtonsView(
                              buttons: [
                                PadButtonItem(
                                  index: 4,
                                  backgroundColor: Colors.black,
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.arrowtriangle_right,
                                    color: Color(0xFFFFFFFF),
                                    size: 40,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 1,
                                  backgroundColor: Colors.black,
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.arrowtriangle_down,
                                    color: Color(0xFFFFFFFF),
                                    size: 40,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 2,
                                  backgroundColor: Colors.black,
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.arrowtriangle_left,
                                    color: Color(0xFFFFFFFF),
                                    size: 40,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 3,
                                  backgroundColor: Colors.black,
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.arrowtriangle_up,
                                    color: Color(0xFFFFFFFF),
                                    size: 40,
                                  ),
                                ),
                              ],
                              padButtonPressedCallback:
                                  padButtonPressedCallback,
                            ),
                            PadButtonsView(
                              buttons: [
                                PadButtonItem(
                                  index: 8,
                                  backgroundColor: Colors.green[600],
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.circle,
                                    color: Color(0xFFEEEEEE),
                                    size: 35,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 5,
                                  backgroundColor: Colors.amber[300],
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.multiply,
                                    color: Color(0xFFEEEEEE),
                                    size: 43,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 6,
                                  backgroundColor: Colors.red[600],
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.square,
                                    color: Color(0xFFEEEEEE),
                                    size: 35,
                                  ),
                                ),
                                PadButtonItem(
                                  index: 7,
                                  backgroundColor: Colors.blue,
                                  pressedColor: Colors.lightBlue,
                                  buttonIcon: Icon(
                                    CupertinoIcons.triangle,
                                    color: Color(0xFFEEEEEE),
                                    size: 32,
                                  ),
                                ),
                              ],
                              padButtonPressedCallback:
                                  padButtonPressedCallback,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      // show('No device selected');
      Fluttertoast.showToast(
          msg: "No Device Selected",
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[700]);
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        //     show('Device connected');
        Fluttertoast.showToast(
            msg: "Device Connected",
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[700]);

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    // show('Device disconnected');
    Fluttertoast.showToast(
        msg: "Device Disconnected",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700]);
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  // Method to show a Snackbar,
  // taking message as the text
  // Future show(
  //   String message, {
  //   Duration duration: const Duration(seconds: 3),
  // }) async {
  //   await new Future.delayed(new Duration(milliseconds: 100));
  //   _scaffoldKey.currentState.showSnackBar(
  //     new SnackBar(
  //       content: new Text(
  //         message,
  //       ),
  //       duration: duration,
  //     ),
  //   );
  // }
}
