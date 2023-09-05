import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/values/constant.dart';
import '../../common/themes/colors.dart';
import '../../common/global/global.dart';
import 'bloc/welcome_blocs.dart';
import 'bloc/welcome_events.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  //page controller to control page changes
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBlocs, WelcomeStates>(
          builder: (context, state){
            return Container(
              margin: EdgeInsets.only(top: 30.h),
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    //register pageController
                    controller: pageController,
                    onPageChanged: (index){
                      //access state from state variable and assign the index. state value hold all the value.
                      state.page = index;
                      //should update last value to UI, call WelcomeEvent and registered WelcomeBloc, find from Bloc and execute.
                      BlocProvider.of<WelcomeBlocs>(context).add(WelcomeEvents());
                    },
                    children: [
                      page(
                          1,
                          context,
                          "Next",
                          "Explore Wonderful Journey",
                          "Welcome to Travel Guide! It offers you a wide range of destinations to help you explore amazing attractions around the world.",
                          "assets/images/welcome1.jpg"//Photo by Dino Reichmuth on Unsplash
                      ),
                      page(
                          2,
                          context,
                          "Next",
                          "Discover Beautiful Scenery",
                          "Discover the attractions that suit you and enjoy a unique and wonderful journey. Make traveling an unforgettable experience.",
                          "assets/images/welcome2.jpg"//Photo by Julian Timmerman on Unsplash
                      ),
                      page(
                          3,
                          context,
                          "Get Started",
                          "Start Travel Guide",
                          "Start your trip! Let us help you explore the beauty and wonder of the world with our travel guides.",
                          "assets/images/welcome3.jpg"//Photo by Mantas Hesthaven on Unsplash
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 180.h,
                    child: DotsIndicator(
                      //use state to position
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          color: AppColors.dotColor,
                          activeColor: AppColors.btnColor,
                          size: const Size.square(8.0),
                          activeSize: const Size(15.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }

  Widget page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath){
    return Column(
      children: [
        SizedBox(
          width: 350.w,
          height: 350.w,
          child: Image.asset(
              imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Text(
            title,
            style: TextStyle(
                color: AppColors.contentTitleColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Text(
            subTitle,
            style: TextStyle(
                color: AppColors.contentColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        //button container
        GestureDetector(
          onTap: (){
            if(index<3){
              pageController.animateToPage(
                  index,//certain page index
                  duration: const Duration(milliseconds: 300),//slide time
                  curve: Curves.decelerate
              );
            }else{
              //jump to login page
              Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 120.h, left: 20.w, right: 20.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: AppColors.btnColor,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1)
                  )
                ]
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: AppColors.btnTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
