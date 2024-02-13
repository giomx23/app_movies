import 'package:app_movies/providers/movie_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/widgets/exports_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MovieProvider>(context);
// print('$moviesProvider');
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
              CardSwiper( movies: moviesProvider.onDisplayMovies,),

              const SizedBox(height: 20),

              //TARJETAS DE ABAJO (MOVIES SLIDER)
              MovieSliderHScreen(
                movies: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        )
      );
    }
  }
