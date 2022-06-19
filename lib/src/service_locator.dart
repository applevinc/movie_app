import 'package:get_it/get_it.dart';
import 'package:movie_app/src/core/helpers/request_helper.dart';
import 'package:movie_app/src/services/genre/genre_service.dart';
import 'package:movie_app/src/services/genre/genre_service_impl.dart';
import 'package:movie_app/src/services/movie/movie_service.dart';
import 'package:movie_app/src/services/movie/movie_service_impl.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/genres_controller.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:http/http.dart' as http;

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //controllers
  serviceLocator.registerFactory(() => MoviesController(movieService: serviceLocator()));
  serviceLocator.registerFactory(() => GenresController(genreService: serviceLocator()));

  //service
  serviceLocator.registerLazySingleton<MovieService>(
      () => MovieServiceImpl(requestHelper: serviceLocator()));
  serviceLocator.registerLazySingleton<GenreService>(
      () => GenreServiceImpl(requestHelper: serviceLocator()));

  //external
  serviceLocator.registerLazySingleton(() => RequestHelper(client: http.Client()));
}
