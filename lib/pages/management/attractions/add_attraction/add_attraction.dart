import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/entities/category.dart';
import 'package:travelguide/pages/management/attractions/add_attraction/add_attraction_controller.dart';
import 'package:travelguide/pages/management/attractions/add_attraction/widget/add_attraction_widget.dart';

import '../../../../common/themes/colors.dart';
import '../../../../common/widgets/common_widgets.dart';
import '../../../../common/widgets/toast.dart';
import 'bloc/add_attraction_blocs.dart';
import 'bloc/add_attraction_events.dart';
import 'bloc/add_attraction_states.dart';

class AddAttraction extends StatefulWidget {
  final String attractionId;
  const AddAttraction({super.key, required this.attractionId});

  @override
  State<AddAttraction> createState() => _AddAttractionState();
}

class _AddAttractionState extends State<AddAttraction> {
  late String attractionId;
  late TextEditingController nameController;
  late TextEditingController cityController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    attractionId = widget.attractionId;
    //init textfield controller
    nameController = TextEditingController();
    cityController = TextEditingController();
    descriptionController = TextEditingController();
    if(attractionId.isEmpty){//add an attraction
      //load category list
      AddAttractionController(context: context).getCategoryResults();
    }else{//edit an attraction
      loadAttractionData(context);
    }
  }

  Future<void> loadAttractionData(BuildContext context) async {
    await AddAttractionController(context: context).getCategoryResults();
    await AddAttractionController(context: context).getAttractionById(attractionId);
    // Use the addPostFrameCallback method to perform a callback after the UI is drawn
    // so that the state values from the state update are loaded into the UI component.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AddAttractionBlocs>().state;
      nameController.text = state.name;
      cityController.text = state.city;
      descriptionController.text = state.description;
    });
  }

  void clearState(BuildContext context) {
    context.read<AddAttractionBlocs>().add(const AttractionIdEvent(""));
    context.read<AddAttractionBlocs>().add(const NameEvent(""));
    context.read<AddAttractionBlocs>().add(const CityEvent(""));
    context.read<AddAttractionBlocs>().add(const DescriptionEvent(""));
    context.read<AddAttractionBlocs>().add(const CategoryIdEvent(""));
    context.read<AddAttractionBlocs>().add(const AverageRatingEvent(0.0));
    context.read<AddAttractionBlocs>().add(const ImageUrlEvent(""));
    File myFile = File('');
    context.read<AddAttractionBlocs>().add(SelectedImageEvent(myFile));
    context.read<AddAttractionBlocs>().add(const CategoryResultsEvent([]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAttractionBlocs, AddAttractionStates>(
        builder: (context, state){
          return WillPopScope(
            onWillPop: () async {
              //clear state
              clearState(context);
              return true;
            },
            child: Scaffold(
              appBar: commonAppBarWidget("Add an attraction", titleColor: AppColors.appBarColor, showBackButton: true),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textFieldWidget(
                          nameController,
                          "Name",
                          (value) {
                            context.read<AddAttractionBlocs>().add(NameEvent(value));
                          }
                      ),
                      textFieldWidget(
                          cityController,
                          "City",
                              (value) {
                            context.read<AddAttractionBlocs>().add(CityEvent(value));
                          }
                      ),
                      SizedBox(height: 5.h),
                      const Text(
                        'Category',
                        style: TextStyle(
                          color: AppColors.contentColor,
                          fontSize: 16
                        ),
                      ),
                      DropdownButton<String>(
                        //Note: When the initial value of categoryId is an empty string,
                        //you need to set the initial value of the drop-down box to null,
                        //otherwise the drop-down box will not be loaded.
                        value: state.categoryId.isNotEmpty ? state.categoryId : null,
                        onChanged: (newValue) {
                          context.read<AddAttractionBlocs>().add(CategoryIdEvent(newValue!));
                        },
                        isExpanded: true,
                        items: state.categoryResults.map<DropdownMenuItem<String>>(
                              (Category category) => DropdownMenuItem<String>(
                            value: category.categoryId,
                            child: Text(
                                category.name,
                            ),

                          ),
                        ).toList(),
                      ),
                      SizedBox(height: 10.h),
                      labelWidget("Description"),
                      SizedBox(height: 15.h),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a description of the attraction.',
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                          maxLength: 200,
                          onChanged: (value){
                            context.read<AddAttractionBlocs>().add(DescriptionEvent(value));
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      labelWidget("Image"),
                      SizedBox(height: 15.h),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Take a Photo'),
                                    onTap: () async {
                                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                                      if (pickedImage != null && mounted) {
                                        File selectedImage = File(pickedImage.path);
                                        context.read<AddAttractionBlocs>().add(SelectedImageEvent(selectedImage));
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Choose from Gallery'),
                                    onTap: () async {
                                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                      if (pickedImage != null) {
                                        File selectedImage = File(pickedImage.path);
                                        context.read<AddAttractionBlocs>().add(SelectedImageEvent(selectedImage));
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: state.selectedImage != null && state.selectedImage!.path.isNotEmpty
                              ? Image.file(state.selectedImage!, fit: BoxFit.cover)
                              : state.imageUrl.isNotEmpty
                              ? Image.network(state.imageUrl, fit: BoxFit.cover)
                              : const Icon(Icons.add),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ElevatedButton(
                        onPressed: () async {
                          String attractionId = context.read<AddAttractionBlocs>().state.attractionId;
                          String name = context.read<AddAttractionBlocs>().state.name;
                          String city = context.read<AddAttractionBlocs>().state.city;
                          String categoryId = context.read<AddAttractionBlocs>().state.categoryId;
                          String description = context.read<AddAttractionBlocs>().state.description;
                          File? selectedImage = context.read<AddAttractionBlocs>().state.selectedImage;
                          double averageRating = context.read<AddAttractionBlocs>().state.averageRating;

                          if(name.isEmpty){
                            toastInfo(msg: "Please enter the name of the attraction.");
                            return;
                          }
                          if(city.isEmpty){
                            toastInfo(msg: "Please enter the city of the attraction.");
                            return;
                          }
                          if(categoryId.isEmpty){
                            toastInfo(msg: "Please select the category of attractions.");
                            return;
                          }
                          if(description.isEmpty){
                            toastInfo(msg: "Please enter the description of the attraction.");
                            return;
                          }
                          if(attractionId.isEmpty && selectedImage==null){
                            toastInfo(msg: "Please select an image for the attraction.");
                            return;
                          }
                          Map<String, dynamic> attraction = {
                            'name': name,
                            'city': city,
                            'categoryId': categoryId,
                            'description': description,
                            'averageRating': averageRating,
                            'createTime': FieldValue.serverTimestamp()
                          };
                          if(attractionId.isEmpty){//add an attraction page
                            String newAttractionId = await AddAttractionController(context: context).addAttractionData(attraction);
                            String downloadUrl = await AddAttractionController(context: context).uploadImageAndGetDownloadUrl(selectedImage!, newAttractionId, name);
                            await AddAttractionController(context: context).updateAttractionImageUrl(newAttractionId,downloadUrl);
                          }else{//edit an attraction page
                            await AddAttractionController(context: context).updateAttractionData(attraction,attractionId);
                            if(selectedImage!=null){//No picture was replaced
                              if(selectedImage.path.isNotEmpty){
                                String downloadUrl = await AddAttractionController(context: context).uploadImageAndGetDownloadUrl(selectedImage, attractionId, name);
                                await AddAttractionController(context: context).updateAttractionImageUrl(attractionId,downloadUrl);
                              }
                            }
                          }
                          //clear state
                          clearState(context);
                          bool saveBack = true;
                          Navigator.pop(context,saveBack);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.btnColor), // Red background color
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50.0)), // Increased height
                        ),
                        child: const Text('Save', style: TextStyle(fontSize: 18.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );

  }
}
