import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travelguide/common/themes/colors.dart';
import 'package:travelguide/common/widgets/common_widgets.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/management/category/bloc/category_management_blocs.dart';
import 'package:travelguide/pages/management/category/bloc/category_management_events.dart';
import 'package:travelguide/pages/management/category/category_management_controller.dart';

import 'bloc/category_management_states.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({super.key});

  @override
  State<CategoryManagement> createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {

  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //load category list
    CategoryManagementController(context: context).getCategoryResults();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryManagementBlocs, CategoryManagementStates>(
        builder: (context, state){
          return Scaffold(
            appBar: commonAppBarWidget("Category Management", titleColor: AppColors.appBarColor, showBackButton: true),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 20,
                          controller: categoryController,
                          onChanged: (value){
                            context.read<CategoryManagementBlocs>().add(CategoryNameEvent(value));
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter category name',
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.btnColor),
                            ),
                          ),
                          style: TextStyle(
                              color: AppColors.contentTitleColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.sp
                          ),
                        ),
                      ),

                      const SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          String categoryName = state.categoryName;
                          bool saveState = await CategoryManagementController(context: context).addCategory(categoryName);
                          if (saveState) {
                            // Clear value
                            context.read<CategoryManagementBlocs>().add(CategoryNameEvent(""));
                            // Clear TextField
                            categoryController.clear();
                            CategoryManagementController(context: context).getCategoryResults();
                            toastInfo(msg: "Add successfully.");
                          } else {
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.btnColor, //background color
                          onPrimary: AppColors.bgColor, //text color
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: state.categoryResults.map((category) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(category.name),
                              Text(
                                DateFormat('yyyy-MM-dd HH:mm').format(category.createTime),
                                style: const TextStyle(
                                  color: AppColors.contentColor,
                                  fontSize: 14
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                                Icons.delete,
                                color: AppColors.deleteIconColor
                            ),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Deletion'),
                                    content: const Text('Are you sure you want to delete this category?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String categoryId = category.categoryId;
                                          await CategoryManagementController(context: context).deleteCategory(categoryId);
                                          await CategoryManagementController(context: context).getCategoryResults();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
