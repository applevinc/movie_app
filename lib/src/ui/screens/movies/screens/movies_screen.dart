import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/core/assets/icons.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:movie_app/src/ui/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _fetchLatestMovies();
  }

  Future<List<Movie>> _fetchLatestMovies() async {
    final controller = context.read<MoviesController>();

    if (controller.movies.isEmpty) {
      try {
        return await controller.fetchLatestMovies();
      } on Failure {
        rethrow;
      }
    } else {
      return controller.movies;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Top Movies',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                AppIcons.search,
                height: 20.h,
                width: 20.h,
              ),
            ),
          ),
        ],
      ),
      body: AsyncBuilder<List<Movie>>(
        future: _movies,
        waiting: (context) => const Center(child: CircularProgressIndicator()),
        builder: (context, movies) {
          if (movies == null) {
            return const _EmptyMoviesScreen();
          }
          return _MoviesListView(movies);
        },
        error: (context, err, _) {
          final error = err as Failure;
          return _ErrorScreen(message: error.message);
        },
      ),
    );
  }
}

class _MoviesListView extends StatelessWidget {
  const _MoviesListView(this.movies, {Key? key}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const _EmptyMoviesScreen();
    }
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

class _EmptyMoviesScreen extends StatelessWidget {
  const _EmptyMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.hourglass_empty,
          size: 34.h,
          color: Colors.white,
        ),
        SizedBox(height: 20.h),
        Text(
          'No movies at the moment',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
        )
      ],
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 34.h,
          color: Colors.white,
        ),
        SizedBox(height: 20.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
