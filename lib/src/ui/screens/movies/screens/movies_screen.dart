import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/core/assets/icons.dart';
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
      return controller.fetchLatestMovies();
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
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(AppIcons.search),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<MoviesController>(
          builder: (BuildContext context, controller, Widget? child) {
            return FutureBuilder<List<Movie>>(
              future: _movies,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:

                  default:
                    if (snapshot.hasError) {
                      final error = snapshot.error;

                      return _ErrorScreen(message: error.toString());
                    } else if (snapshot.hasData) {
                      final featuredMovie = controller.featuredMovie;
                      final movies = controller.movies;

                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.only(top: 8.h),
                            sliver: SliverToBoxAdapter(
                              child: MovieTile(featuredMovie!, isFeatured: true),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final movie = movies[index];
                                return MovieTile(movie);
                              },
                              semanticIndexCallback: (Widget widget, int localIndex) {
                                return 16.h.toInt();
                              },
                              childCount: movies.length,
                            ),
                          ),
                        ],
                      );
                    } else {
                      const _EmptyMoviesScreen();
                    }
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
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
