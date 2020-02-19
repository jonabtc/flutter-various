import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EstablishmentFrame extends StatefulWidget {
  @override
  _EstablishmentFrameState createState() => _EstablishmentFrameState();
}

class _EstablishmentFrameState extends State<EstablishmentFrame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          CarouselSlider(
            items: _lista(),
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            aspectRatio: 2.0,
          ),
          _createFavoritesSection(),
          Divider(),
      ],
    );
  }

  List<Widget> _lista() {
    List<Widget> lista = [];

    for (var i = 0; i < 10; i++) {
      lista.add(
        Stack(
          children:[
            FadeInImage(
              image: NetworkImage('https://picsum.photos/300/200/?image=$i'),
              placeholder: AssetImage('assets/no-image.jpg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text('Establecimiento\nDestacado', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Banner pagado', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  ]
                ),
                FlatButton(
                  child: Icon(
                    Icons.arrow_forward_ios, 
                    color: Colors.white,
                    ),
                  color: Colors.transparent,
                  onPressed: (){},
                )
              ],
            ),
          ],
        ),
      );
    }
    return lista;
  }

  Widget _createFavoritesSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal:15.0, vertical: 10.0),
            child: Text('Favoritos', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
            )
          ),
        CarouselSlider(
          items: _listaFavoritos(),
          autoPlay: false,
          enlargeCenterPage: false,
          viewportFraction: 0.8,
          aspectRatio: 1.0,
        )
        
      ]
    );
  }

  List <Widget> _listaFavoritos(){
    List <Widget> lista = [];

    for (var i = 0; i < 6; i ++){
      lista.add(
        Column(
          
          children: <Widget>[
            FadeInImage(
              image: NetworkImage('https://picsum.photos/200/200/?image=$i'),
              placeholder: AssetImage('assets/no-image.jpg'),
              width: 88.0,
              height: 88.0

            ),
            Text('Nombre', style: TextStyle(fontSize: 15.0))
          ],
        )
      );
    }

    return lista;
  }
}
