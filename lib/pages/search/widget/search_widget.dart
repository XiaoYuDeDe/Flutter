import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/themes/colors.dart';
import '../../../entities/attraction.dart';
import '../../attractions/attractions.dart';

Widget listViewCardWidget (BuildContext context, Attraction attraction){
  return GestureDetector(
    onTap: (){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AttractionsDetail(attraction: attraction),
        ),
      );
    },
    child: Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(5.0),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.listColor),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  attraction.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.contentTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.iconColor),
                  Text(
                    attraction.averageRating.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Image.asset(
                "assets/icons/location.png",
                width: 20.w,
                height: 20.h,
                color: AppColors.iconColor,
              ),
              const SizedBox(width: 5),
              Text(
                attraction.city,
                style: const TextStyle(
                  color: AppColors.contentTitleColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}