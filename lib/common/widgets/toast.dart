import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelguide/common/themes/colors.dart';

toastInfo({required String msg,
      Color backgroundColor = AppColors.bgColor,
      Color textColor = AppColors.contentTitleColor,
      int durationInSeconds = 3}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: durationInSeconds,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.sp
  );
}
