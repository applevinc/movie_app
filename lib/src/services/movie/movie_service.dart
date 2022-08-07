import 'package:movie_app/src/models/movie.dart';

abstract class MovieService {
  Future<List<Movie>> fetchLatestMovies({required int page});
  Future<List<Movie>> search(String query);
}
