import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:concept_test/src/pages/location_verification_page.dart';
import 'package:concept_test/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
     // home: Scaffold(body: Center(child:_crearWidgets()),),
      initialRoute: 'location',
      routes:{
        'login'     :   (BuildContext context) => LoginPage(),
        'location'  :   (BuildContext context) => LocationVerificationPage(),
      }
    );
  }

  _crearWidgets() {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlatButton(
          child: Text('Activar Estado'),
          onPressed: (){
            Location().requestPermission().then((valor)=>debugPrint('Permiso de uso: $valor'));
          },
        ),

  FlatButton(
          child: Text('Activar Location'),
          onPressed: (){
            Location().requestService().then((valor)=>debugPrint('Permiso de activación: $valor'));
          },
        ),

      ],
    );
  }
}


