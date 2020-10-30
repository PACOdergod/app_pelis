import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/providers/peliculas_provider.dart';
import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class SearchData extends SearchDelegate {
  final peliculaProvider = new PeliculaProvider();

  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Implementar el icono a la izquierda
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementar los resultados
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implementar las sugerencias de busqueda

    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculaProvider.buscar(query),
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((Pelicula pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  width: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(pelicula.title),
                onTap: () {
                  close(context, null);
                },
              );
            }),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
