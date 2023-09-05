import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_blocs.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_events.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_states.dart';
import 'package:travelguide/pages/navigation/widget/navigation_widgets.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBlocs, NavigationStates>(builder: (context, state){
      return Container(
        color: AppColors.bgColor,
        child: SafeArea(
          child: Scaffold(
            body: pageWidget(state.index),//display different page by index
            bottomNavigationBar: Container(
              width: 375.w,
              height: 60.h,
              decoration: BoxDecoration(
                  color: AppColors.barLineColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h)
                  ),
                  boxShadow: [
                    BoxShadow(//for top line
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]
              ),
              child: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (value){
                  context.read<NavigationBlocs>().add(TriggerNavigationEvents(value));
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: AppColors.btnColor,
                unselectedItemColor: AppColors.contentColor,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                items: bottomTabs,
              ),
            ),
          ),
        ),
      );
    });
  }
}

