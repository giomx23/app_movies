import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:app_movies/models/exports_models.dart';
import 'package:app_movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot){

        if(!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(
              maxWidth: 150,
            ),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast>  cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          height: 190,
          // color: Colors.teal,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(cast[index]),
            ),
          );
        },
      );
    }
  }



class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 100,
      padding: EdgeInsets.only(top: 10),
      // color: Colors.tealAccent,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              width: 120,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 10,),

          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}