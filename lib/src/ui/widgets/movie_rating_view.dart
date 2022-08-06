import 'package:flutter/material.dart';
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
      width: 116.w,
      height: 24.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: const Color(0xff252634),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // RatingBar(
          //   initialRating: rating,
          //   direction: Axis.horizontal,
          //   itemCount: 5,
          //   itemSize: 12.sp,
          //   maxRating: 10.0,
          //   wrapAlignment: WrapAlignment.center,
          //   ratingWidget: RatingWidget(
          //     full: const Icon(
          //       Icons.star,
          //       color: AppColors.yellow,
          //     ),
          //     half: const Icon(
          //       Icons.star_half,
          //       color: AppColors.yellow,
          //     ),
          //     empty: const Icon(
          //       Icons.star_border,
          //       color: AppColors.yellow,
          //     ),
          //   ),
          //   itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
          //   onRatingUpdate: (rating) {
          //     print(rating);
          //   },
          // ),
          Wrap(
            spacing: 4.w,
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: AppColors.yellow,
                size: 11.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '${rating.toInt()}/5',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textGray,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
