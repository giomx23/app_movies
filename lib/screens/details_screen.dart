import 'package:flutter/material.dart';

import 'package:app_movies/widgets/exports_widgets.dart';

class DetailsScreen extends StatelessWidget {

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'No-Movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _OverviewScreen(),
              _OverviewScreen(),
              _OverviewScreen(),
              _OverviewScreen(),
              _OverviewScreen(),
              CastingCards(),
            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
          padding: EdgeInsets.only(bottom: 5),
          child: const Text(
            'Movie Title',
            style: TextStyle(fontSize: 20),
            )
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x270'),
              height: 200,
            ),
          ),

          SizedBox(width: 15,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie title',
                style: textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'Movie original-title',
                style: textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star_outline, size: 20, color: Colors.teal,),
                  SizedBox(width: 5,),
                  Text('Movie Vote-Avarage', style: textTheme.bodySmall,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


class _OverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
         child:
         Text(
         'Lorem consequat mollit minim duis cupidatat. Ut aute ea proident excepteur sint reprehenderit reprehenderit. Veniam veniam do duis reprehenderit adipisicing et elit nulla nostrud officia. Nisi esse cupidatat excepteur nisi ut consequat amet. Culpa ut officia nisi do pariatur. Aliquip ipsum irure voluptate exercitation.',
         textAlign: TextAlign.justify,
         style: Theme.of(context).textTheme.labelMedium,
         ),
      );
  }
}