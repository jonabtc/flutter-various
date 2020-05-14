import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaskTextInputFormatterExample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamplePage(title: 'ExamplePage'),
    );
  }
}

class ExamplePage extends StatefulWidget {
  final String title;
  String valueString = '';

  ExamplePage({Key key, this.title}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {

  
  var textEditingController = TextEditingController();
  
  // var maskTextInputFormatter = MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    Icon icon;
    textEditingController.text = widget.valueString;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextField(                
                inputFormatters: [MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 (123) 123-45-67",
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Phone number',
                  alignLabelWithHint: false,                  
                  )
              ),
              TextField(
                controller: textEditingController,
                inputFormatters: [MaskTextInputFormatter(mask: "#### #### #### ####", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  icon: icon,
                ),
                onChanged: (value){
                  widget.valueString += value;                  
                   setState(() {
                      if(widget.valueString.length > 4)
                     icon = Icon(Icons.card_giftcard);
                   });
                  
                },
              ),
              TextField(
                // controller: textEditingController,
                inputFormatters: [MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 (123) 123-45-67",
                  fillColor: Colors.white,
                  filled: true,
                  )
              ),
              TextField(
                // controller: textEditingController,
                inputFormatters: [MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 (123) 123-45-67",
                  fillColor: Colors.white,
                  filled: true,
                  ),
                
              ),
              TextField(
                // controller: textEditingController,
                inputFormatters: [MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 (123) 123-45-67",
                  fillColor: Colors.white,
                  filled: true,
                  )
              ),
              TextField(
                // controller: textEditingController,
                inputFormatters: [MaskTextInputFormatter(mask: "+# (###) ###-##-##", filter: { "#": RegExp(r'[0-9]') })],
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+1 (123) 123-45-67",
                  fillColor: Colors.white,
                  filled: true,
                  )
              ),
            ],
          )
        )
      )
    );
  }
}