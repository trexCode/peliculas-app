import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/movie.dart';
import 'package:peliculas_app/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '4cc39e2fde4bb05e9428eab1a01aa3e4';
  final String _languague = 'es-ES';

  List<Movie> onDislpayMovies = [];
  List<Movie> popularMovies = [];
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _languague,
        'page': '1',
      },
    );

    final response = await http.get(url);
    final nowPlayinResponse = NowPlayingResponse.fromJson(response.body);
    onDislpayMovies = nowPlayinResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {
        'api_key': _apiKey,
        'language': _languague,
        'page': '1',
      },
    );

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results]; 
    notifyListeners();
  }
}
