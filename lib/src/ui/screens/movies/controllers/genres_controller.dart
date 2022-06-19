import 'package:flutter/cupertino.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/genre.dart';
import 'package:movie_app/src/services/genre/genre_service.dart';

class GenresController extends ChangeNotifier {
  final GenreService _genreService;
  List<Genre> _genres = [];

  GenresController({required GenreService genreService}) : _genreService = genreService;

  Future<void> fetchGenres() async {
    try {
      _genres = await _genreService.fetchGenres();
    } on Failure {
      rethrow;
    }
  }

  String generateGenre(dynamic genreIds) {
    List<String> movieGenreList = [];

    for (int id in genreIds) {
      for (var genreItem in _genres) {
        if (id == genreItem.id) {
          movieGenreList.add(genreItem.name);
        }
      }
    }

    return movieGenreList.join(' / ');
  }
}
