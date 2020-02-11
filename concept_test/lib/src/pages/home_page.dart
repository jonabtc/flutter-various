import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page'),
              FlatButton(
               child: Text('Login'),
               onPressed: ()=>Navigator.pushReplacementNamed(context, 'login'), 
              )
            ]
          ),
        ),      
    );
  }
}