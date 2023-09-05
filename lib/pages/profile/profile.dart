import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/common/routes/routes.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/pages/profile/profile_controller.dart';
import 'package:travelguide/pages/profile/widget/profile_widget.dart';
import '../../common/global/global.dart';
import '../../common/themes/colors.dart';
import 'bloc/profile_blocs.dart';
import 'bloc/profile_states.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late File uploadImage;

  late String userId; // User's email prefix as a class member
  late String userName;
  late String email;

  @override
  void initState() {
    super.initState();
    // Load the user's email prefix from userInfo
    final userInfo = Global.storageService.getUserInfo();
    email = userInfo["email"];
    userName = userInfo["username"];
    userId = userInfo["userId"];
    // Load the profile image URL from Firebase Storage when the page loads
    ProfileController(context: context).loadProfileImage(userId,userName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBlocs, ProfileStates>(
        builder: (context, state){
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: commonAppBarWidget(
                "Profile",
                titleColor: AppColors.appBarColor,
                showBackButton: false
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: AppColors.pageTitleColor,
                          backgroundImage: state.imageUrl != ""
                              ? NetworkImage(state.imageUrl) as ImageProvider
                              : null,
                          child: state.imageUrl == ""
                              ? const Icon(
                              Icons.person,
                              size: 80,
                              color: AppColors.bgColor
                          )
                              : null,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                            if (pickedImage != null) {
                                              uploadImage = File(pickedImage.path);
                                              await ProfileController(context: context).uploadImage(uploadImage,userId,userName);
                                              await ProfileController(context: context).loadProfileImage(userId,userName);
                                              Navigator.pop(context);
                                            }
                                          },
                                          leading: const Icon(Icons.camera, color: AppColors.linkColor),
                                          title: const Text("Take a Photo"),
                                        ),
                                        ListTile(
                                          onTap: () async {
                                            final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            if (pickedImage != null) {
                                              uploadImage = File(pickedImage.path);
                                              await ProfileController(context: context).uploadImage(uploadImage,userId,userName);
                                              await ProfileController(context: context).loadProfileImage(userId,userName);
                                              Navigator.pop(context);
                                            }
                                          },
                                          leading: const Icon(Icons.image, color: AppColors.linkColor),
                                          title: const Text("Choose from Gallery"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.bgColor,
                            child: Icon(Icons.add, size: 20, color: AppColors.iconColor),
                          ),
                        )
                      ],

                    ),
                    // profilePhotoWidget(),
                    SizedBox(height: 30.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userInfoRowWidget("assets/icons/user.png", "User:", userName),
                        const Divider(thickness: 1, color: AppColors.barLineColor), // Divider between rows
                        userInfoRowWidget("assets/icons/mail.png", "Email:", email),
                        const Divider(thickness: 1, color: AppColors.barLineColor)
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Column(
                      children:[
                        addProfileBarWidget(
                            context,
                            "Settings",
                            AppRoutes.SETTINGS,
                            "assets/icons/settings.png",
                            userId),
                        SizedBox(height: 15.h),
                        addProfileBarWidget(
                            context,
                            "Category Management",
                            AppRoutes.CATEGORY_MANAGEMENT,
                            "assets/icons/category.png",
                            userId),
                        SizedBox(height: 15.h),
                        addProfileBarWidget(
                            context,
                            "Attraction Management",
                            AppRoutes.ATTRACTION_MANAGEMENT,
                            "assets/icons/addlist.png",
                            userId),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );

  }
}
