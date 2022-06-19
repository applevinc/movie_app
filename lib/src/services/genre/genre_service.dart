import 'package:movie_app/src/models/genre.dart';

abstract class GenreService {
  Future<List<Genre>> fetchGenres();
}
