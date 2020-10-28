import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Text(pelicula.title),
      ),
    );
  }
}
