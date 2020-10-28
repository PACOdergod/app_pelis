import 'package:app_pelis/src/models/pelicula_model.dart';
import 'package:app_pelis/src/pages/pelicula_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * .25,
      child: PageView.builder(
        //children: _tarjetas(context),
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int i) =>
            _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    //Diseño de las terjetas
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 100.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
        child: tarjeta,
        onTap: () {
          Navigator.of(context).pushNamed('/detalle', arguments: pelicula);
        });
  }

  List<Widget> _tarjetas(context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
