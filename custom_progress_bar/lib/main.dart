import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double value = 0;
  Random rand = Random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Color(0xff00e5ff),
        appBar: AppBar(
          title: Text('Custom Linear Progress Bar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TaskProgressIndicator(
              colorProgressCompleted: Colors.redAccent[400],
              colorProgressIncompleted: Colors.white,
              progressValue: value,
            ),
            RaisedButton(
              color: Colors.black,
              child: Text('$value', style: TextStyle(color:Colors.white),),
              onPressed: value >= 100
                  ? null
                  : () {
                      setState(() {
                        value += rand.nextInt(20);
                      });
                    },
            )
          ],
        ),
      ),
    );
  }

  initS() async {
    while (value < 100.0) {
      await Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
        value += 10;
        print(value);
      });
    }
  }

  _build() {
    return Row(
      children: [
        Icon(Icons.ac_unit),
        SizedBox(
          width: 13,
        ),
        Expanded(child: LinearProgressIndicator()),
        SizedBox(
          width: 13,
        ),
        Icon(Icons.ac_unit),
        SizedBox(
          width: 13,
        ),
        Expanded(child: LinearProgressIndicator()),
        SizedBox(
          width: 13,
        ),
        Icon(Icons.ac_unit),
        SizedBox(
          width: 13,
        ),
        Expanded(child: LinearProgressIndicator()),
        SizedBox(
          width: 13,
        ),
        Icon(Icons.ac_unit),
      ],
    );
  }
}

class TaskProgressIndicator extends StatefulWidget {
  final Color colorProgressCompleted;
  final Color colorProgressIncompleted;
  final double progressValue;

  const TaskProgressIndicator({
    Key key,
    @required this.colorProgressCompleted,
    @required this.colorProgressIncompleted,
    @required this.progressValue,
  }) : super(key: key);
  @override
  _TaskProgressIndicatorState createState() => _TaskProgressIndicatorState();
}

class _TaskProgressIndicatorState extends State<TaskProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.store,
              color: getColor(0),
            ),
            Expanded(
              child: LinearProgressIndicator(
                backgroundColor: widget.colorProgressIncompleted,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.colorProgressCompleted),
                value: getProgressValue(1),
              ),
            ),
            Icon(Icons.store, color: getColor(1)),
            Expanded(
              child: LinearProgressIndicator(
                backgroundColor: widget.colorProgressIncompleted,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.colorProgressCompleted),
                value: getProgressValue(2),
              ),
            ),
            Icon(Icons.store, color: getColor(2)),
            Expanded(
              child: LinearProgressIndicator(
                backgroundColor: widget.colorProgressIncompleted,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.colorProgressCompleted),
                value: getProgressValue(3),
              ),
            ),
            Icon(Icons.store, color: getColor(3)),
          ],
        ),
      ],
    );
  }

  getProgressValue(int step) {
    int total = 3;
    double cien = 100 / total;
    double percent;
    double progress = widget.progressValue;
    if ((progress - cien * step >= 0)) {
      percent = 100;
    } else {
      double valor = (progress - cien * (step - 1)) * 100 / cien;
      percent = valor > 0 ? valor : 0;
    }
    return percent / 100;
  }

  getColor(int step) {
    double progress = widget.progressValue;
    progress /= 100;
    int total = 3;
    if (progress == 1) return widget.colorProgressCompleted;
    if (progress <= (1 / total) * step) {
      return widget.colorProgressIncompleted;
    } else {
      return widget.colorProgressCompleted;
    }
  }
}
