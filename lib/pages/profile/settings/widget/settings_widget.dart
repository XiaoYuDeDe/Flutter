import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_blocs.dart';
import 'package:travelguide/pages/navigation/bloc/navigation_events.dart';

import '../../../../common/global/global.dart';
import '../../../../common/routes/routes.dart';
import '../../../../common/values/constant.dart';

Widget settingsLogoutWidget(BuildContext context){
  return GestureDetector(
    onTap: (){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
                onPressed: ()=>Navigator.of(context).pop(),
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: () async {
                  final userInfo = Global.storageService.getUserInfo();
                  String loginType = userInfo["loginType"];
                  if(loginType == "google"){
                    await GoogleSignIn().signOut();
                  }
                  context.read<NavigationBlocs>().add(const TriggerNavigationEvents(0));
                  Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
                  Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
                },
                child: const Text("Comfirm")
            )
          ],
        );
      });
    },
    child: Container(
      height: 100.h,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/icons/logout.png")
          )
      ),
    ),
  );
}