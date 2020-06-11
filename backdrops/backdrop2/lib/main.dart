import 'package:backdrop2/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:backdrop2/step1.dart';
import 'package:backdrop2/step2.dart';
import 'package:backdrop2/step3.dart';
import 'package:backdrop2/step4.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            SizedBox(height: 32.0),
            RaisedButton(
              child: Text("Step1"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step1Page()));
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text("Step2"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step2Page()));
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text("Step3"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step3Page()));
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text("Step4"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Step4Page()));
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text("Backdrop widget"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Backdrop(
                      backPanel: ListView.separated(
                        itemBuilder: (_, index) => ListTile(
                          title: Text('Item $index'),
                        ),
                        separatorBuilder: (_, __) => Divider(
                          color: Colors.red,
                        ),
                        itemCount: 16,
                      ),
                      frontPanel: Center(
                        child: Text('FRONT PANEL'),
                      ),
                      frontPanelTittle: Text('Principal Panel'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Tabs backdrop'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Backdrop.tabBar(
                      backPanel: ListView.separated(
                        itemBuilder: (_, index) => ListTile(
                          title: Text('Item $index'),
                        ),
                        separatorBuilder: (_, __) => Divider(
                          color: Colors.red,
                        ),
                        itemCount: 16,
                      ),
                      tabBar: TabBar(
                        labelColor: Colors.black87,
                        tabs: [
                          Tab(text: 'PAGE 1'),
                          Tab(text: 'PAGE 2'),
                        ],
                      ),
                      tabBarView: TabBarView(
                        children: [
                          Center(
                            child: Text('Content page 1'),
                          ),
                          Center(
                            child: Text('Content page 2'),
                          ),
                        ],
                      ),
                      onPressedLeading: (_) => print('Se ha dado click $_'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
