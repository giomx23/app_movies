import 'package:flutter/material.dart';

class MovieSliderHScreen extends StatelessWidget {

  const MovieSliderHScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity, //PARA QUE OCUPE EL ANCHO DEL SCREEN
    height: 250,
    // color: Colors.teal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Popular movies', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ),

        const SizedBox(height: 3,),

        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (_, int index) => _MovieSlider(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget { //CUANDO ES PRIVADO SE PONE UN GUIÓN BAJO (_)

  const _MovieSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.tealAccent,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com//300x400'),
                width: 130,
                height: 170,
                fit: BoxFit.cover,
                ),
            ),
          ),

          const SizedBox(height: 5,),

            const Text(
              'One Piece',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    }