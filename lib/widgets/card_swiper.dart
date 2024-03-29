import 'package:flutter/material.dart';

import 'package:app_movies/models/exports_models.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    super.key,
    required this.movies
    });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

     if( this.movies.length == 0){
       return Container(
         width: double.infinity,
         height: size.height * 0.5,
         child: Center(
           child: CircularProgressIndicator(),
         ),
       );
     }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.grey,

      //SLIDE
    child: Swiper(
      itemCount: movies.length,
      layout: SwiperLayout.TINDER,
      itemWidth: size.width * 0.7,
      itemHeight: size.height * 0.6,
      itemBuilder: (_, int index){

        final movie = movies[index];
        // print(movie.fullPosterImg);
        movie.heroID = 'swiper-${movie.id}';

        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: movie), //PARA IR A LOS DETALLES DE LA PELÍCULA
          child: Hero(
            tag: movie.heroID!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              )
            ),
          ),
        );
      },
    )
    );
  }
}