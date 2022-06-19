import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/core/assets/icons.dart';
import 'package:movie_app/src/core/styles/color.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/genres_controller.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:movie_app/src/ui/widgets/movie_rating_view.dart';
import 'package:movie_app/src/ui/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(this.movie, {Key? key, required this.isFeatured})
      : super(key: key);

  final Movie movie;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _InfoSection(movie, isFeatured: isFeatured),
            _TrendingMoviesSection(movie),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection(this.movie, {Key? key, required this.isFeatured}) : super(key: key);

  final Movie movie;
  final bool isFeatured;

  String _getGenres({required List<int> genreIds, required BuildContext context}) {
    final controller = context.read<GenresController>();
    return controller.generateGenre(genreIds);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      clipBehavior: Clip.none,
      children: [
        Image.network(
          movie.poster,
          height: 472.h,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -100.h,
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primary.withOpacity(.5),
                  AppColors.primary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.2, 0.3, 0.7],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 125.h),
                Text(
                  'Top movie of the week',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppIcons.medal),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.sp,
                                ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '${movie.releaseDate.year} • ${_getGenres(context: context, genreIds: movie.genres)} • 2h 5m',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontSize: 12.sp,
                                  color: const Color(0xffCDCED1),
                                ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            movie.description,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(height: 16.h),
                          MovieRatingView(movie),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _TrendingMoviesSection extends StatelessWidget {
  const _TrendingMoviesSection(this.movie, {Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 150.h),
          child: Text(
            'Also trending',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
        ),
        SizedBox(height: 8.h),
        Consumer<MoviesController>(
          builder: (BuildContext context, controller, Widget? child) {
            final movies = controller.getTrending(movie);
            return ListView.builder(
              itemCount: movies.length < 4 ? movies.length : 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieTile(movie);
              },
            );
          },
        ),
      ],
    );
  }
}
