import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/utils/firebase_helper.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/favorite/bloc/favorites_blocs.dart';
import 'package:travelguide/pages/favorite/bloc/favorites_events.dart';

import '../../entities/favorite.dart';

class FavoritesController{

  final BuildContext context;

  const FavoritesController({required this.context});

  Future<void> getFavoriteAttractions(String userId) async {
    List<Favorite> favoriteAttractions = [];
    CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
    try {
      DocumentSnapshot userDoc = await favoritesCollection.doc(userId).get();
      if (userDoc.exists) {
        CollectionReference attractionsCollection = userDoc.reference.collection('attractions');
        QuerySnapshot attractionsSnapshot = await attractionsCollection.get();

        favoriteAttractions = attractionsSnapshot.docs.map((attractionDoc) {
          Map<String, dynamic> data = attractionDoc.data() as Map<String, dynamic>;
          return Favorite(
            favoriteId: attractionDoc.id,
            attractionName:  data['name'],
            attractionImgUrl: data['imageUrl'],
            favoriteTime: data['favoriteTime'].toDate(),
            isFavorite: data['isFavorite']
          );
        }).toList();
        context.read<FavoritesBlocs>().add(FavoritesResultEvent(favoriteAttractions));
      }
    } catch (error) {
      toastInfo(msg: 'Error getting favorite attractions: $error');
    }
  }

  Future<void> removeFavoriteAttraction(String userId, String attractionId) async {
    final CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
    try {
      await favoritesCollection
          .doc(userId)
          .collection('attractions')
          .doc(attractionId)
          .delete();
    } catch (error) {
      toastInfo(msg:'Error removing attraction from favorites: $error');
    }
  }
}