import 'package:app_pelis/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }
}
