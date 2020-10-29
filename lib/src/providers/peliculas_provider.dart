import 'dart:async';
import 'package:app_pelis/src/models/actores_model.dart';
import 'package:app_pelis/src/models/pelicula_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apikey = '50ad3ef3075abddf4124aaa0b7d2adb3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 2;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposesStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '/3/movie/$peliId/credits', {
      'api_key': _apikey,
    });

    //print(url);

    final resp = await http.get(url);
    final encodeFirst = json.encode(resp.body);
    final decodedData = json.decode(encodeFirst);

    //print(decodedData);

    String jsonsDataString = decodedData.toString();
    final jsonData = jsonDecode(jsonsDataString);

    //print(jsonsDataString);

    final cast = new Cast.fromJsonList(jsonData['cast']);

    return cast.actores;
  }
}
