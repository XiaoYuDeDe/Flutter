import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/management/attractions/add_attraction/bloc/add_attraction_blocs.dart';
import 'package:travelguide/pages/management/attractions/add_attraction/bloc/add_attraction_events.dart';

import '../../../../common/utils/firebase_helper.dart';
import '../../../../entities/category.dart';

class AddAttractionController{

  final BuildContext context;

  const AddAttractionController({required this.context});

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      File selectedImage = File(pickedImage.path);
      context.read<AddAttractionBlocs>().add(SelectedImageEvent(selectedImage));
    }
  }

  Future<void> getCategoryResults() async {
    List<Category> categoryList = [];
    final CollectionReference categoriesCollection = FirebaseHelper.categoriesCollection;

    try {
      QuerySnapshot querySnapshot = await categoriesCollection.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        String categoryId = documentSnapshot.id;
        String categoryName = data['name'];
        DateTime createTime = data['createTime'].toDate();

        Category category = Category(
          categoryId: categoryId,
          name: categoryName,
          createTime: createTime,
        );
        categoryList.add(category);
      }
      context.read<AddAttractionBlocs>().add(CategoryResultsEvent(categoryList)) ;
    } catch (error) {
      toastInfo(msg: 'Error retrieving categories: $error');
    }
  }

  Future<String> addAttractionData(Map<String, dynamic> attraction) async {
    final attractionsCollection = FirebaseHelper.attractionsCollection;
    try {
        // Add new attraction
        DocumentReference newAttractionRef = await attractionsCollection.add(attraction);
        String newAttractionId = newAttractionRef.id; // Get the newly generated document ID
        return newAttractionId;
    } catch (error) {
      toastInfo(msg: 'Error adding attraction: $error');
      return "";
    }
  }

  Future<void> updateAttractionData(Map<String, dynamic> attraction, String attractionId) async {
    final attractionsCollection = FirebaseHelper.attractionsCollection;
    try {// Update existing attraction
        await attractionsCollection.doc(attractionId).update(attraction);
    } catch (error) {
      toastInfo(msg: 'Error adding attraction: $error');
    }
  }

  Future<String> uploadImageAndGetDownloadUrl(File selectedImage, String attractionId, String name) async {
    final Reference storageRef = FirebaseStorage.instance.ref().child('attractions_images/$attractionId/$name.jpg');
    try {
      final UploadTask uploadTask = storageRef.putFile(selectedImage);
      await uploadTask.whenComplete(() => null);

      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      toastInfo(msg: 'Error uploading image: $e');
      return "";
    }
  }

  Future<void> updateAttractionImageUrl(String attractionId, String imageUrl) async {
    final attractionsCollection = FirebaseHelper.attractionsCollection;
    try {
      await attractionsCollection.doc(attractionId).update({'imageUrl': imageUrl});
      toastInfo(msg: 'Attraction imageUrl updated successfully');
    } catch (error) {
      toastInfo(msg: 'Error updating attraction imageUrl: $error');
    }
  }

  Future<void> getAttractionById(String attractionId) async {
    final CollectionReference attractionsCollection = FirebaseHelper.attractionsCollection;
    try {
      DocumentSnapshot attractionSnapshot = await attractionsCollection.doc(attractionId).get();

      if (attractionSnapshot.exists) {
        Map<String, dynamic> attractionData = attractionSnapshot.data() as Map<String, dynamic>;
        String attractionId = attractionSnapshot.id;
        String name = attractionData['name'];
        String city = attractionData['city'];
        String description = attractionData['description'];
        String categoryId = attractionData['categoryId'];
        double averageRating = attractionData['averageRating'].toDouble();
        String imageUrl = attractionData['imageUrl'];
        context.read<AddAttractionBlocs>().add(AttractionIdEvent(attractionId));
        context.read<AddAttractionBlocs>().add(NameEvent(name));
        context.read<AddAttractionBlocs>().add(CityEvent(city));
        context.read<AddAttractionBlocs>().add(DescriptionEvent(description));
        context.read<AddAttractionBlocs>().add(CategoryIdEvent(categoryId));
        context.read<AddAttractionBlocs>().add(AverageRatingEvent(averageRating));
        context.read<AddAttractionBlocs>().add(ImageUrlEvent(imageUrl));
      }

    } catch (error) {
      toastInfo(msg: 'Error getting attraction: $error');
    }
  }

  void clearState(){

  }
}