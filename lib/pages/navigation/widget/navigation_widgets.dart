import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/pages/favorite/favorites.dart';
import 'package:travelguide/pages/home/home.dart';
import 'package:travelguide/pages/profile/profile.dart';

import '../../search/search.dart';

Widget pageWidget(int index){
  List<Widget> widgets = [
    const Home(),
    const Search(),
    const Favorites(),
    const Profile(),
  ];

  return widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "home",
      icon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset("assets/icons/home.png"),
      ),
      activeIcon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset(
            "assets/icons/home.png",
            color: AppColors.btnColor
        ),
      )
  ),
  BottomNavigationBarItem(
      label: "search",
      icon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset("assets/icons/search.png"),
      ),
      activeIcon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset(
            "assets/icons/search.png",
            color: AppColors.btnColor
        ),
      )
  ),
  BottomNavigationBarItem(
      label: "favorite",
      icon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset("assets/icons/favorite.png"),
      ),
      activeIcon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset(
            "assets/icons/favorite.png",
            color: AppColors.btnColor
        ),
      )
  ),
  BottomNavigationBarItem(
      label: "profile",
      icon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset("assets/icons/user.png"),
      ),
      activeIcon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset(
            "assets/icons/user.png",
            color: AppColors.btnColor
        ),
      )
  ),
];