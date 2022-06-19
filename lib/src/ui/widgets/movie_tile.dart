import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/styles/color.dart';
import 'package:movie_app/src/core/utils/navigator.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/genres_controller.dart';
import 'package:movie_app/src/ui/screens/movies/screens/movie_detail_screen.dart';
import 'package:movie_app/src/ui/widgets/movie_rating_view.dart';
import 'package:provider/provider.dart';

class MovieTile extends StatelessWidget {
  const MovieTile(this.movie, {Key? key, this.isFeatured = false}) : super(key: key);

  final bool isFeatured;
  final Movie movie;

  String _getGenres({required List<int> genreIds, required BuildContext context}) {
    final controller = context.read<GenresController>();
    return controller.generateGenre(genreIds);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AppNavigator.to(context, MovieDetailScreen(movie, isFeatured: isFeatured)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isFeatured ? AppColors.blue : const Color(0xff1B1C2A),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: movie.poster,
                height: 168.h,
                width: 118.w,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 167.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${_getGenres(context: context, genreIds: movie.genres)} ${movie.releaseDate.year}',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontSize: 12.sp,
                                color: isFeatured
                                    ? const Color(0xffCCE5FF)
                                    : AppColors.textGray),
                          ),
                        ],
                      ),
                      const Spacer(),
                      MovieRatingView(movie),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
