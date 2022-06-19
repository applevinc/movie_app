import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/src/core/styles/color.dart';
import 'package:movie_app/src/models/movie.dart';

class MovieRatingView extends StatelessWidget {
  const MovieRatingView(
    this.movie, {
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final rating = movie.rating / 2;

    return Container(
      height: 24.h,
      width: 125.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: const Color(0xff252634),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBar(
            initialRating: rating,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 12.h,
            maxRating: 10.0,
            wrapAlignment: WrapAlignment.center,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star,
                color: AppColors.yellow,
                size: 12.sp,
              ),
              half: Icon(
                Icons.star_half,
                color: AppColors.yellow,
                size: 12.sp,
              ),
              empty: Icon(
                Icons.star_border,
                color: AppColors.yellow,
                size: 12.sp,
              ),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          Text(
            '${rating.toInt()}/5',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 12.sp, color: AppColors.textGray),
          ),
        ],
      ),
    );
  }
}
