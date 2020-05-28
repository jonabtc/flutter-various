import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationsManager();
    pushProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Selector(),
      ),
    );
  }
}

class Selector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return toggleButtons();
  }

  Widget specialCharsPanel() {
    return Container(
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            specialChar("A"),
            specialChar("B"),
            specialChar("C"),
            specialChar("D"),
            specialChar("E"),
            specialChar("F"),
            specialChar("G"),
          ],
        ),
      ),
    );
  }
  Widget toggleButtons(){
    return ToggleButtons(
    children: [
      specialChar("A"),
            specialChar("B"),
            specialChar("C"),
            specialChar("D"),
            specialChar("E"),
            specialChar("F"),
            specialChar("G"),
    ], 
    onPressed: (int index){
      setState((){
        for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        if (buttonIndex == index) {
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });
  },
  isSelected: isSelected,
      
    });
  

  Widget specialChar(String str) {
    return ButtonTheme(
      minWidth: 40.0,
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {},
        child: Text(str),
      ),
    );
  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    String token = await _firebaseMessaging.getToken();
    print("[DEBUG] FirebaseMessaging token: $token");
    if (!_initialized) {
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions();
      }
      _firebaseMessaging.configure(onResume: (map) {
        print('[DEBUG]: (onResume) map: ${map.toString()}');
        return;
      }, onBackgroundMessage: (map) {
        print('[DEBUG]: (onBackgroundMessage) map: ${map.toString()}');
        return;
      }, onLaunch: (map) {
        print('[DEBUG]: (onLaunch) map: ${map.toString()}');
        return;
      }, onMessage: (map) {
        print('[DEBUG]: (onMessage) map: ${map.toString()}');
        return;
      });
      _initialized = true;
    }
  }
}
