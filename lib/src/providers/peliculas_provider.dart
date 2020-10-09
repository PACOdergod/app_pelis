import 'package:app_pelis/src/models/pelicula_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apikey = '50ad3ef3075abddf4124aaa0b7d2adb3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    final urlf = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(urlf);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
}
