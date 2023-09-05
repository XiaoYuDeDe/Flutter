import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travelguide/pages/attractions/attractions_controller.dart';
import 'package:travelguide/pages/attractions/bloc/attractions_blocs.dart';
import '../../../common/themes/colors.dart';
import '../../../entities/attraction.dart';
import '../../../entities/review.dart';

Widget attractionsDetailWidget(Attraction attraction, BuildContext context){
  final state = context.read<AttractionsBlocs>().state;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              attraction.name, //attraction name
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.iconColor),
                const SizedBox(width: 5),
                Text(
                  state.averageRating.toString(), //attraction averageRating
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Image.asset(
              "assets/icons/location.png",
              width: 20.w,
              height: 20.h,
              color: AppColors.iconColor,
            ),
            const SizedBox(width: 5),
            Text(
              attraction.city, //attraction city
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          attraction.description, //attraction description
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}

Widget reviewsWidget(BuildContext context, String userId, String attractionId, List<Review> reviewsResult){
  if (reviewsResult.isEmpty) {
    return Center(
      child: Text(
        "No Reviews.",
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.contentTitleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else {
    List<Widget> columns = [];

    for (int i = 0; i < reviewsResult.length; i++) {
      columns.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      reviewsResult[i].username,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.contentTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Text(
                  DateFormat("MMM d, yyyy").format(reviewsResult[i].commentTime),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.contentTitleColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    double rating = reviewsResult[i].rating;
                    int fullStars = rating.toInt();
                    double halfStar = rating - fullStars;

                    if (index < fullStars) {
                      return const Icon(Icons.star, color: AppColors.iconColor);
                    } else if (index == fullStars && halfStar > 0) {
                      return const Icon(Icons.star_half, color: AppColors.iconColor);
                    } else {
                      return Icon(Icons.star_border, color: AppColors.iconColor);
                    }
                  }),
                ),
                const SizedBox(width: 5),
                Text(
                  reviewsResult[i].rating.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.contentTitleColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (userId == "HXIPw6e7ZUftqKlvDCqL9vvOQsq1") //admin remove reviews
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text('Are you sure you want to delete this reviews?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  //remove reviews
                                  await AttractionsController(context: context)
                                      .removeReviews(attractionId, reviewsResult[i].reviewsId);
                                  //recalculate the average rating
                                  await AttractionsController(context: context)
                                      .updateAverageRating(context, attractionId);
                                  //reload reviews results
                                  await AttractionsController(context: context)
                                      .getAttractionReviews(context,attractionId);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );

                    },
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              reviewsResult[i].content,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.contentTitleColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 10),
            i != reviewsResult.length - 1 ? Divider() : SizedBox(),
          ],
        ),
      );
    }

    return Column(
      children: columns,
    );
  }
}