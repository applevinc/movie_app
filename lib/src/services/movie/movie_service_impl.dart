import 'package:movie_app/src/core/constants/api_urls.dart';
import 'package:movie_app/src/core/helpers/request_helper.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/services/movie/movie_service.dart';

class MovieServiceImpl implements MovieService {
  final RequestHelper _requestHelper;

  MovieServiceImpl({required RequestHelper requestHelper})
      : _requestHelper = requestHelper;

  @override
  Future<List<Movie>> fetchLatestMovies({required int page}) async {
    var url = '/movie/popular?api_key=${APIUrls.apiKey}&language=en-US&page=$page';

    try {
      final response = await _requestHelper.getRequest(url: url);
      final List collection = response['results'];
      return collection.map((json) => Movie.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw Failure('Server error, try again later');
    }
  }

  @override
  Future<List<Movie>> search(String query) async {
    var url =
        '/search/movie?api_key=${APIUrls.apiKey}&language=en-US&query=$query&page=1&include_adult=false';

    try {
      final response = await _requestHelper.getRequest(url: url);
      final List collection = response['results'];
      return collection.map((json) => Movie.fromJson(json)).toList();
    } on Failure {
      rethrow;
    } on Error {
      throw Failure('Server error, try again later');
    } on Exception {
      throw Failure('Server error, try again later');
    }
  }
}
