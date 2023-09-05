import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelguide/pages/register/bloc/register_blocs.dart';
import 'package:travelguide/pages/register/bloc/register_events.dart';
import 'package:travelguide/pages/register/bloc/register_states.dart';
import 'package:travelguide/pages/register/register_controller.dart';
import 'package:travelguide/pages/register/widget/register_widget.dart';
import '../../common/themes/colors.dart';
import '../../common/widgets/common_widgets.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(builder: (context, state){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: commonAppBarWidget("Sign up", titleColor:AppColors.appBarColor),
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
                        commonLabelWidget("User name"),
                        commonTextFieldWidget("Enter your user name", "name", "user", (value){
                          context.read<RegisterBlocs>().add(UserNameEvent(value));
                        }),

                        commonLabelWidget("Email"),
                        commonTextFieldWidget("Enter your email address", "email", "mail", (value){
                          context.read<RegisterBlocs>().add(EmailEvent(value));
                        }),
                        commonLabelWidget("Password"),
                        commonTextFieldWidget("Enter your password", "password", "lock", (value){
                          context.read<RegisterBlocs>().add(PasswordEvent(value));
                        }),

                        commonLabelWidget("Confirm password"),
                        commonTextFieldWidget("Enter your Confirm password", "password", "relock", (value){
                          context.read<RegisterBlocs>().add(ConfirmPasswordEvent(value));
                        })
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: commonLabelWidget("By clicking sign up, you confirm that you accept our General terms and conditions.", isBold: false),
                  ),

                  signUpButtonWidget((){//login change button color
                    // Navigator.of(context).pushNamed("register");
                    RegisterController(context: context).handleEmailRegister();
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
