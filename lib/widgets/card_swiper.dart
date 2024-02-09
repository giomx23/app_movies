
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.grey,

      //SLIDE
    child: Swiper(
      itemCount: 10,
      layout: SwiperLayout.TINDER,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.4,
      itemBuilder: (_, int index){

        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'), //PARA IR A LOS DETALLES DE LA PELÍCULA
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/300x400'),
              fit: BoxFit.cover,
            )
          ),
        );
      },
    )
    );
  }
}