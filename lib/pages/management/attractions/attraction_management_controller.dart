import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/entities/attraction.dart';
import 'package:travelguide/pages/management/attractions/bloc/attraction_management_blocs.dart';
import 'package:travelguide/pages/management/attractions/bloc/attraction_management_events.dart';

import '../../../common/utils/firebase_helper.dart';
import '../../../common/widgets/toast.dart';
class AttractionManagementController{

  final BuildContext context;

  const AttractionManagementController({required this.context});

  Future<void> getAttractions() async {
    final CollectionReference attractionsCollection = FirebaseHelper.attractionsCollection;
    List<Attraction> attractionList = [];
    try {
      QuerySnapshot querySnapshot = await attractionsCollection.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String,dynamic>;
        final Attraction attraction = Attraction(
            attractionId: documentSnapshot.id,
            name: data['name'],
            city: data['city'],
            description: data['description'],
            averageRating: data['averageRating'].toDouble(),
            imageUrl: data['imageUrl'],
            categoryId: data['categoryId'],
            createTime: data['createTime'].toDate()

        );
        attractionList.add(attraction);
      }
      attractionList.sort((a, b) => b.createTime.compareTo(a.createTime));
      context.read<AttractionManagementBlocs>().add(
          AttractionResultsEvent(attractionList));
    } catch (error) {
      toastInfo(msg: 'Error retrieving categories: $error');
    }
  }

  Future<void> deleteAttraction(String attractionId, String attractionName) async {
    try {
      // Step 1: Delete reviews for the attraction
      final CollectionReference reviewsCollection = FirebaseHelper.reviewsCollection;
      await reviewsCollection.doc(attractionId).delete();

      // Step 2: Delete favorites for the attraction
      final CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
      QuerySnapshot favoritesSnapshot = await favoritesCollection.get();

      for (QueryDocumentSnapshot favoriteDoc in favoritesSnapshot.docs) {
        CollectionReference attractionsCollection = favoriteDoc.reference.collection('attractions');
        await attractionsCollection.doc(attractionId).delete();
      }

      // Step 3: Delete the attraction itself
      CollectionReference attractionsCollection = FirebaseHelper.attractionsCollection;
      await attractionsCollection.doc(attractionId).delete();

      // Step 4: Delete image from Firebase Storage
      final Reference storageRef = FirebaseStorage.instance.ref()
          .child('attractions_images/$attractionId/$attractionName.jpg');
      await storageRef.delete();

    } catch (error) {
      toastInfo(msg: 'Error deleting attraction: $error');
      // Handle the error if needed
    }
  }

}