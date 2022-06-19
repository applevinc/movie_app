import 'package:movie_app/src/models/movie.dart';

abstract class MovieService {
  Future<List<Movie>> fetchLatestMovies();
}
