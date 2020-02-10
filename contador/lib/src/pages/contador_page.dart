import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget{

  @override
  createState()=>_ContadorPageState();
  

}

class _ContadorPageState extends State<ContadorPage>{

  final _estiloTexto = new TextStyle(fontSize: 25);

  int _contador = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Número de clicks:', style: _estiloTexto,),
            Text('$_contador', style: _estiloTexto,),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: _crearBotones(), 
    );
  }

  Widget _crearBotones(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0,),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: _reset,),
        Expanded(child: SizedBox()),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: _sustraer,),
        FloatingActionButton(child: Icon(Icons.add), onPressed: _agregar,),

      ],
    );
  }

  void _agregar(){
   setState(()=> _contador++); 
  }
  void _sustraer(){
   setState(() {
            if(_contador != 0){
              _contador--;
            }
          });
  }
  void _reset(){
   setState(()=>_contador = 0); 
  }
}

