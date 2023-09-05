import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/themes/colors.dart';

Widget textFieldWidget(TextEditingController controller, String textName, void Function(String value)? function){
  return Container(
    height: 60.h,
    child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: textName,
          labelStyle: const TextStyle(
            color: AppColors.contentColor,
          ),
        ),
        textAlign: TextAlign.left,
        maxLength: 20,
        onChanged: (value)=>function!(value)
    ),
  );
}

Widget labelWidget(String labelName){
  return Text(
    labelName,
    style: const TextStyle(
        color: AppColors.contentColor,
        fontSize: 16
    ),
  );
}

