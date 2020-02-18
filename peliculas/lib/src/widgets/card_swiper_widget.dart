import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    return Container(        
        padding: EdgeInsets.only(top: 17.0),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: MediaQuery.of(context).size.width * 0.7,
          itemBuilder: (BuildContext cont, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
            ),
          );
          },
          itemCount: peliculas.length,
        ));
  }
}
