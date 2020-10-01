import 'package:app_pelis/src/providers/peliculas_provider.dart';
import 'package:app_pelis/src/widgets/card_swiper_widget.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final peliculaProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas'),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: null)
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [_swiperTarjetas()],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculaProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
