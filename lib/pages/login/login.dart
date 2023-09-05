import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/pages/login/bloc/login_blocs.dart';
import 'package:travelguide/pages/login/bloc/login_events.dart';
import 'package:travelguide/pages/login/bloc/login_states.dart';
import 'package:travelguide/pages/login/login_controller.dart';
import 'package:travelguide/pages/login/widget/login_widget.dart';
import '../../common/widgets/common_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBlocs, LoginStates>(
        builder: (context, state){
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: commonAppBarWidget("Log in",titleColor:AppColors.appBarColor, showBackButton: false),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,//make elements left
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonLabelWidget("Email"),
                          SizedBox(height: 5.h),
                          commonTextFieldWidget("Enter your email address", "email", "mail",
                            (value){
                              context.read<LoginBlocs>().add(EmailEvent(value));
                            }
                          ),
                          commonLabelWidget("Password"),
                          SizedBox(height: 5.h),
                          commonTextFieldWidget("Enter your password", "password", "lock",
                              (value){
                                context.read<LoginBlocs>().add(PasswordEvent(value));
                              }
                          )
                        ],
                      ),
                    ),
                    forgotPasswordWidget(context),
                    loginButtonWidget(() {
                      LoginController(context: context).handleLogin("email");
                    }),
                    signUpButtonWidget((){
                      Navigator.of(context).pushNamed("/register");
                    }),
                    SizedBox(height: 25.h),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 15.w),
                          const Expanded(child: Divider(color: AppColors.contentTitleColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text("or", style: TextStyle(fontSize: 18.sp)),
                          ),
                          const Expanded(child: Divider(color: AppColors.contentTitleColor)),
                          SizedBox(width: 15.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Center(child: commonLabelWidget("Use third-party account to login.",isBold:false)),
                    SizedBox(height: 5.h),
                    thirdPartyLoginWidget(context),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
