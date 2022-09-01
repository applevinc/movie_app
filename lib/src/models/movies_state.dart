import 'package:movie_app/src/models/movie.dart';

abstract class MovieListState {}

class MovieList extends MovieListState {
  final List<Movie> movies;

  MovieList(this.movies);
}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);
}
