import 'package:app_movies/models/exports_models.dart';
import 'package:flutter/material.dart';

class MovieSliderHScreen extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSliderHScreen(
    {
      super.key,
      required this.movies,
      required this.onNextPage,
      this.title,
    });

  @override
  State<MovieSliderHScreen> createState() => _MovieSliderHScreenState();
}

class _MovieSliderHScreenState extends State<MovieSliderHScreen> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 350) {
        widget.onNextPage();
      }
      // print(scrollController.position.pixels);
      // print(scrollController.position.maxScrollExtent);

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity, //PARA QUE OCUPE EL ANCHO DEL SCREEN
    height: 280,
    // color: Colors.teal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if(widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text( widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

        const SizedBox(height: 5,),

        Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (_, int index) => _MovieSlider(widget.movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget { //CUANDO ES PRIVADO SE PONE UN GUIÓN BAJO (_)

  final Movie movie;

  const _MovieSlider(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.tealAccent,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 170,
                fit: BoxFit.cover,
                ),
            ),
          ),

          const SizedBox(height: 5,),

          Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    }