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
      children: [
        Stack(children: [
          CarouselSlider(
            items: _lista(),
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            aspectRatio: 2.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:50.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text('Establecimiento\nDestacado', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 30.0,),
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
          ),
        ]),
      ],
    );
  }

  List<Widget> _lista() {
    List<Widget> lista = [];

    for (var i = 0; i < 10; i++) {
      lista.add(FadeInImage(
        image: NetworkImage('https://picsum.photos/300/200/?image=$i'),
        placeholder: AssetImage('assets/no-image.jpg'),
      ));
    }
    return lista;
  }
}
