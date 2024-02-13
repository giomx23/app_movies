import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:app_movies/models/exports_models.dart';
import 'package:http/http.dart' as http;


class MovieProvider extends ChangeNotifier{

  final String _apiKey   = '4269879e057d063eb39e7809a39f4fbc';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;


  MovieProvider(){
    print('Movie Provider initialization');

    getOnDisplayMovie();
    getPopularMovies();
  }

  Future<String>_getJsonData(String endpoint, [int page=1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
      });

      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(url);
      return response.body;
  }

  getOnDisplayMovie() async{

    final jsonData = await this._getJsonData('3/movie/now_playing');
      // print(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async{

    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular',1);

    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId) async{
 
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    // print('Pidiendo información al servidor - CAST');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}