import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/management/category/bloc/category_management_blocs.dart';
import 'package:travelguide/pages/management/category/bloc/category_management_events.dart';

import '../../../common/utils/firebase_helper.dart';
import '../../../entities/category.dart';

class CategoryManagementController{
  final BuildContext context;

  const CategoryManagementController({required this.context});

  Future<void> getCategoryResults() async {
    final CollectionReference categoriesCollection = FirebaseHelper.categoriesCollection;
    List<Category> categoryList = [];
    try {
      QuerySnapshot querySnapshot = await categoriesCollection.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        final Category category = Category(
          categoryId: documentSnapshot.id,
          name: data['name'],
          createTime: data['createTime'].toDate(),
        );
        categoryList.add(category);
      }
      categoryList.sort((a, b) => b.createTime.compareTo(a.createTime));
    } catch (error) {
      toastInfo(msg: 'Error retrieving categories: $error');
    }
    context.read<CategoryManagementBlocs>().add(CategoryResultsEvent(categoryList));
  }

  Future<bool> addCategory(String categoryName) async {
    if (categoryName.isEmpty) {
      toastInfo(msg: "Please enter a category name.");
      return false;
    } else {
      final CollectionReference categoriesCollection = FirebaseHelper.categoriesCollection;
      // Check if the category already exists
      final querySnapshot = await categoriesCollection
          .where('name', isEqualTo: categoryName).get();

      if (querySnapshot.docs.isNotEmpty) {
        toastInfo(msg: "Category '$categoryName' already exists.");
        return false;
      } else {
        try {
          await categoriesCollection.add({
            'name': categoryName,
            'createTime': FieldValue.serverTimestamp()
          });
          return true; // New category added successfully
        } catch (error) {
          toastInfo(msg: 'Error adding category: $error');
          return false;
        }
      }
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    final CollectionReference categoriesCollection = FirebaseHelper.categoriesCollection;
    // Check if any attraction document has the same categoryId
    final QuerySnapshot attractionsSnapshot = await FirebaseHelper.attractionsCollection
        .where('categoryId', isEqualTo: categoryId).get();

    if (attractionsSnapshot.docs.isNotEmpty) {
      toastInfo(msg: 'This category has attraction data, please delete the attraction data first!');
      return;
    }
    try {
      await categoriesCollection.doc(categoryId).delete();
      toastInfo(msg: 'Category deleted successfully');
    } catch (error) {
      toastInfo(msg: 'Error deleting category: $error');
    }
  }


}