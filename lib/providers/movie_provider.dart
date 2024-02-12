import 'dart:convert';

import 'package:app_movies/models/now_playing_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MovieProvider extends ChangeNotifier{

  String _apiKey   = '4269879e057d063eb39e7809a39f4fbc';
  String _baseUrl  = 'api.themoviedb.org';
  String _language = 'es-ES';

  MoviesProvider(){
    print('Movie Provider initialization');

    getOnDisplayMovie();
  }

  getOnDisplayMovie() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      });

      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
      if(response.statusCode != 200) return print('error');

      print(nowPlayingResponse.results[0].title);
  }
}