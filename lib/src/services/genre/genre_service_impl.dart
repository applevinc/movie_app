import 'package:movie_app/src/core/constants/api_urls.dart';
import 'package:movie_app/src/core/helpers/request_helper.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/genre.dart';
import 'package:movie_app/src/services/genre/genre_service.dart';

class GenreServiceImpl implements GenreService {
  final RequestHelper _requestHelper;

  GenreServiceImpl({required RequestHelper requestHelper})
      : _requestHelper = requestHelper;

  @override
  Future<List<Genre>> fetchGenres() async {
    var url = '/genre/movie/list?api_key=${APIUrls.apiKey}&language=en-US';

    try {
      final response = await _requestHelper.getRequest(url: url);
      final List collection = response['genres'];
      return collection.map((json) => Genre.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw Failure('Server error, try again later');
    }
  }
}
