import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ejemplo extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _EjemploState();

}

class _EjemploState extends State <Ejemplo>{

  double _tamanio = 10.0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(
      title: Text('Título del ejemplo'), 
      centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.android, 
            size: _tamanio,
            color: Colors.green,),
            Text('$_tamanio',
            textAlign: TextAlign.center,)
        ],
      ),
      floatingActionButton: _botonesAction(),
      );
  }

  Widget _botonesAction(){
    return Row(
      children: <Widget>[
        SizedBox(width: 30.0,),
        FloatingActionButton(
          onPressed: _aumentar,
          child: Icon(Icons.add),
        ),
        Expanded(child: FloatingActionButton(onPressed: (){setState(()=>_tamanio =50.0);}),),
        FloatingActionButton(
          onPressed: _reducir,
          child: Icon(Icons.remove)
        )
      ],
    );
  }

  void _reducir(){
    setState(() {
      if(_tamanio-5 >=5){
        _tamanio-=5;
        }
    });
  }

  void _aumentar(){
    setState(()=> _tamanio+=5);
  }
}

