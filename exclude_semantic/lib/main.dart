import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //showSemanticsDebugger: true,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool valorGreenExluding = false;
  bool valorBlueExluding = false;
  bool valorRedExluding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
                  child: Stack(
    children: [
      Positioned(
          top: 10,
          left: 10,
          width: 200,
          height: 200,
          child: ExcludeSemantics(
            excluding: valorRedExluding,
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text('red box'),
              ),
            ),
          ),
      ),
      Positioned(
          top: 180,
          left: 150,
          width: 200,
          height: 200,
          child: ExcludeSemantics(
            excluding: valorBlueExluding,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('Blue box'),
              ),
            ),
          ),
      ),
      Positioned(
          top: 350,
          left: 10,
          width: 200,
          height: 200,
          child: ExcludeSemantics(
            excluding: valorGreenExluding,
            child: Container(
              color: Colors.green,
              child: Center(
                child: Text('green box'),
              ),
            ),
          ),
      ),
      Positioned(
        left:15,
          bottom: 10,
          child: Row(
            children: [
              RaisedButton(
                child: Text('BLUE'),
                onPressed: () {
                  setState(() {
                    valorBlueExluding = !valorBlueExluding;
                    print('blue button -> $valorBlueExluding');
                  });
                },
              ),SizedBox(width: 30,),
              RaisedButton(
                child: Text('RED'),
                onPressed: () {
                  setState(() {
                    valorRedExluding = !valorRedExluding;
                    print('red button -> $valorRedExluding');
                  });
                },
              ),
              SizedBox(width: 30,),
              RaisedButton(
                child: Text('GREEN'),
                onPressed: () {
                  setState(() {
                    valorGreenExluding = !valorGreenExluding;
                    print('green button -> $valorGreenExluding');
                  });
                },
              )
            ],
          ),
      ),
    ],
          ),
        ),
      );
  }
}
