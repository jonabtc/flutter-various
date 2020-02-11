import 'package:concept_test/src/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:concept_test/src/pages/location_verification_page.dart';
import 'package:concept_test/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
     // home: Scaffold(body: Center(child:_crearWidgets()),),
      initialRoute: 'login',
      routes:{
        'login'     :   (BuildContext context) => LoginPage(),
        'location'  :   (BuildContext context) => LocationVerificationPage(),
        'home'      :   (BuildContext context) => HomePage(),
      }
    );
  }
}


