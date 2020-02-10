import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 10.0,),
          _cardTipo2(),
          SizedBox(height: 10.0,),
          _cardTipo1(),
          SizedBox(height: 10.0,),
          _cardTipo2(),
          SizedBox(height: 10.0,),
          _cardTipo1(),
          SizedBox(height: 10.0,),
          _cardTipo2(),
          SizedBox(height: 10.0,),
          _cardTipo1(),
          SizedBox(height: 10.0,),
          _cardTipo2(),
          SizedBox(height: 10.0,),
          _cardTipo1(),
          SizedBox(height: 10.0,),
          _cardTipo2(),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue,),
            title: Text('Soy el título de esta tarjeta'),
            subtitle: Text('Quería poner un texto de lorem ipsum pero no me salió.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('CANCELAR'),
                onPressed: (){},
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: (){},
              )
            ],
          )

        ],
      ),
    );
  }

  Widget _cardTipo2() {

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
           FadeInImage(
             image: NetworkImage('https://www.trafalgar.com/-/media/Project/Trafalgar/Product/hero-images/South-America-Landscapes-w.jpg?smartCrop=1&centreCrop=1&w=1000&h=600'),
             placeholder: AssetImage('assets/jar_loading.gif'),
             fadeInDuration: Duration(milliseconds: 200),
             height: 300.0,
             fit: BoxFit.cover,
             
           ),
          // Image(
          //   image: NetworkImage('https://www.trafalgar.com/-/media/Project/Trafalgar/Product/hero-images/South-America-Landscapes-w.jpg?smartCrop=1&centreCrop=1&w=1000&h=600'),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('No tengo idea de que poner'))
        ],
      ),
    );
  }
}