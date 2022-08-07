import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:movie_app/src/ui/widgets/movie_tile.dart';
import 'package:movie_app/src/ui/widgets/search_textfield.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<Movie>> _movies;
  StateSetter? searchState;

  @override
  void initState() {
    super.initState();
    _movies = _fetchLatestMovies();
  }

  Future<List<Movie>> _fetchLatestMovies() async {
    final controller = context.read<MoviesController>();

    if (controller.movies.isEmpty) {
      try {
        return await controller.fetchLatestMovies(page: 1);
      } on Failure {
        rethrow;
      }
    } else {
      return controller.movies;
    }
  }

  Future<List<Movie>> search(String query) async {
    final controller = context.read<MoviesController>();
    if (query.isNotEmpty) {
      try {
        return await controller.search(query);
      } on Failure {
        rethrow;
      }
    } else {
      throw Failure('Enter a movie name');
    }
  }

  Future<void> refresh() async {
    final controller = context.read<MoviesController>();
    _movies = controller.fetchLatestMovies(page: 18);
    searchState!(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SearchWidget(
              onChanged: (query) {
                _movies = search(query);
                searchState!(() {});
              },
              onClose: () => refresh(),
            ),
          ),
          SizedBox(height: 20.h),
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              searchState = searchState ?? setState;

              return AsyncBuilder<List<Movie>>(
                future: _movies,
                waiting: (context) => const CustomLoadingIndicator(),
                builder: (context, movies) {
                  if (movies == null) {
                    return const _EmptyMoviesScreen();
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: _MoviesListView(movies),
                    ),
                  );
                },
                error: (context, err, _) {
                  final error = err as Failure;
                  return _ErrorScreen(
                    message: error.message,
                    onRetry: () => refresh(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
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
  const _ErrorScreen({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  final String message;
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
          SizedBox(height: 10.h),
          TextButton(
            onPressed: onRetry,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
