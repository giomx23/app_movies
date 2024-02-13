import 'package:flutter/material.dart';

import 'package:app_movies/models/exports_models.dart';
import 'package:app_movies/widgets/exports_widgets.dart';

class DetailsScreen extends StatelessWidget {

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    // print(movie.title);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              _OverviewScreen(movie),
              CastingCards(movie.id),
            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;
  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.teal,
      expandedHeight: 200,
      floating: false,
      pinned: true, //PARA QUE EL ENCABEZADO NO DESAPAREZCA
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0), //PARA QUITARLE EL PADDING DE UN TÍTULO Y NO QUEDE ALEJADO DEL CENTRO
        title: Container(
          color: Colors.black26,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 5, right: 5, left: 5),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
            )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);


  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top:20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 200,
              width: 130,
            ),
          ),

          SizedBox(width: 15,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 185),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                movie.title,
                style: textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                ),

                Text(
                  movie.originalTitle,
                  style: textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
            
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.star_outline, size: 20, color: Colors.teal,),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.bodySmall,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _OverviewScreen extends StatelessWidget {

  final Movie movie;

  const _OverviewScreen(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
         child:
         Text(
         movie.overview,
         textAlign: TextAlign.justify,
         style: Theme.of(context).textTheme.labelMedium,
         ),
      );
  }
}