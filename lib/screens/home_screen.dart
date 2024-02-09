import 'package:flutter/material.dart';

import 'package:app_movies/widgets/exports_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies in cinema',
              style: TextStyle(color: Colors.white)),
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(Icons.search_outlined),
                color: Colors.white,
                onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //PANTALLA DE TARJETAS DE ARRIBA
              CardSwiper(),

              //TARJETAS DE ABAJO (MOVIES SLIDER)
              MovieSliderHScreen(),
            ],
          ),
        )
      );
    }
  }
