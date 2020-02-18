import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Películas en cines'),
          centerTitle: false,
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ]),
      body: Container(
        child: Column(          
          children: [
            _swiperTarjetas(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas(BuildContext context) {

    
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData)
          return CardSwiper(peliculas: snapshot.data);
        else
          return Container(
            height: 400.0,
            child:Center(child: CircularProgressIndicator()));
      },
    );
    // peliculasProvider.getEnCines();

    // return CardSwiper(
    //   peliculas: [1,2,3,4,5],
    // );
  }


}
