import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/services/movie/movie_service.dart';

class MoviesController extends ChangeNotifier {
  final MovieService _movieService;
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  Movie? _featuredMovie;
  Movie? get featuredMovie => _featuredMovie;

  MoviesController({required MovieService movieService}) : _movieService = movieService;

  Future<List<Movie>> fetchLatestMovies() async {
    try {
      final results = await _movieService.fetchLatestMovies();

      if (results.isNotEmpty) {
        _featuredMovie = results.first;
        _movies = results;
        _movies.removeAt(0);
      }
      return _movies;
    } on Failure {
      rethrow;
    }
  }

  List<Movie> getTrending(Movie movie) {
    final moviesCopy = _movies;
    moviesCopy.removeWhere(
        (element) => element.title.toLowerCase() == movie.title.toLowerCase());
    return moviesCopy;
  }
}
