import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  
  @override
  Widget build(BuildContext context) {
    print('Se está creando las vistas');
    return Scaffold(
      
    );
  }


  @override
 void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 3));
    print('ya se inicio la página');

  }

}