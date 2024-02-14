import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_movies/helpers/debouncer.dart';

import 'package:app_movies/models/search_response.dart';
import 'package:app_movies/models/exports_models.dart';
import 'package:http/http.dart' as http;


class MovieProvider extends ChangeNotifier{

  final String _apiKey   = '4269879e057d063eb39e7809a39f4fbc';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  MovieProvider(){
    print('Movie Provider initialization');

    getOnDisplayMovie();
    getPopularMovies();
    // _suggestionsStreamController.close();
  }

  Future<String>_getJsonData(String endpoint, [int page=1]) async{
    final url = Uri.https(_baseUrl, endpoint, {
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
    final jsonData = await _getJsonData('3/movie/popular',1);

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

  Future<List<Movie>>searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
    'api_key': _apiKey,
    'language': _language,
    'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){
    debouncer.value = '';
    debouncer.onValue = (value) async {

      // print('Se tiene valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {

      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel()
    );
  }
}