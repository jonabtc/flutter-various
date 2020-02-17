import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apiKey    = 'f57c57b26f91bf63b8080026b11d8d3c';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';


  Future<List<Pelicula>> getEnCines() async {
    
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    
    return [];

  }
}