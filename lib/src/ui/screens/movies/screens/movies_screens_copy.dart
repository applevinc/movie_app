import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/models/movies_state.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:movie_app/src/ui/widgets/error_screen.dart';
import 'package:movie_app/src/ui/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class MoviesScreenCopy extends StatefulWidget {
  const MoviesScreenCopy({Key? key}) : super(key: key);

  @override
  State<MoviesScreenCopy> createState() => _MoviesScreenCopyState();
}

class _MoviesScreenCopyState extends State<MoviesScreenCopy> {
  late Future<MovieListState> _movieListstate;

  @override
  void initState() {
    super.initState();
    _movieListstate = _fetchLatestMovies();
  }

  Future<MovieListState> _fetchLatestMovies() async {
    final controller = context.read<MoviesController>();

    if (controller.movies.isEmpty) {
      try {
        final movies = await controller.fetchLatestMovies(page: 1);
        return MovieList(movies);
      } on Failure {
        rethrow;
      }
    } else {
      return MovieList(controller.movies);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoviesController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Top Movies',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              child: FutureProvider<MovieListState>(
                create: (_) => _movieListstate,
                initialData: MovieList([]),
                catchError: (context, error) {
                  if (error is Failure) {
                    return MovieListError(error.message);
                  }
                  return MovieListError('An Error occuried');
                },
                builder: (context, child) {
                  return const _MoviesListView();
                },
              ),
            ),
    );
  }
}

class _MoviesListView extends StatelessWidget {
  const _MoviesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MovieListState>();

    if (state is MovieListError) {
      return ErrorScreen(
        message: state.message,
        onRetry: () {},
      );
    } else if (state is MovieList) {
      return _Movies(state.movies);
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _Movies extends StatelessWidget {
  const _Movies(this.movies, {Key? key}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];
        return MovieTile(movie);
      },
    );
  }
}
