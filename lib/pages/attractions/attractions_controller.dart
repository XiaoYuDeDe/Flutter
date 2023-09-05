import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/attractions/bloc/attractions_blocs.dart';

import '../../common/utils/firebase_helper.dart';
import '../../entities/attraction.dart';
import '../../entities/review.dart';
import 'bloc/attractions_events.dart';

class AttractionsController{
  final BuildContext context;

  const AttractionsController({required this.context});

  Future<void> getAttractionReviews(BuildContext context, String attractionId) async {
    final CollectionReference reviewsCollection = FirebaseHelper.reviewsCollection;

    final QuerySnapshot commentsSnapshot = await reviewsCollection
        .doc(attractionId)
        .collection('comments')
        .get();

    final List<Review> reviewsResult = [];

    commentsSnapshot.docs.forEach((commentDoc) {
      final Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;

      final Review review = Review(
        reviewsId: commentDoc.id,
        username: commentData['userName'],
        content: commentData['content'],
        rating: commentData['rating'].toDouble(),
        commentTime: commentData['commentTime'].toDate(),
      );

      reviewsResult.add(review);
    });

    // Sort the reviewsResult list by commentTime in descending order
    reviewsResult.sort((a, b) => b.commentTime.compareTo(a.commentTime));
    context.read<AttractionsBlocs>().add(ReviewsResultEvent(reviewsResult));

  }

  Future<void> addReviews(String attractionId, String userName, double rating, String comment) async {

    final CollectionReference reviewsCollection = FirebaseHelper.reviewsCollection;

    try {
      //Create a document under the reviews collection with attractionId as the ID and add a creation time field
      final DocumentReference attractionDocRef = reviewsCollection.doc(attractionId);
      await attractionDocRef.set({
        'createTime': FieldValue.serverTimestamp(),
      });

      final CollectionReference commentsCollection = attractionDocRef.collection('comments');
      await commentsCollection.add({
        'userName': userName,
        'rating': rating,
        'content': comment,
        'commentTime': FieldValue.serverTimestamp()
      });
      toastInfo(msg: 'Comment added successfully!');
    } catch (error) {
      toastInfo(msg:'Error adding attraction to favorites: $error');
    }
  }

  Future<void> removeReviews(String attractionId, String documentId) async {

    final CollectionReference reviewsCollection = FirebaseHelper.reviewsCollection;
    final CollectionReference commentsCollection = reviewsCollection.doc(attractionId).collection('comments');

    try {
      await commentsCollection.doc(documentId).delete();
      toastInfo(msg: "Deleted successfully.");
    } catch (error) {
      toastInfo(msg:'Error deleting attraction document from favorites: $error');
    }
  }

  Future<void> updateAverageRating(BuildContext context, String attractionId) async {
    final CollectionReference commentsCollection = FirebaseHelper.reviewsCollection
        .doc(attractionId)
        .collection('comments');

    final QuerySnapshot commentsSnapshot = await commentsCollection.get();

    double totalRating = 0;
    int totalComments = 0;

    commentsSnapshot.docs.forEach((commentDoc) {
      final Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;

      final double rating = commentData['rating'].toDouble();
      totalRating += rating;
      totalComments++;
    });

    double averageRating = totalComments > 0 ? totalRating / totalComments : 0;
    double averageRatingWithOneDecimal = double.parse(averageRating.toStringAsFixed(1));

    final CollectionReference attractionsCollection = FirebaseHelper.attractionsCollection;


    await attractionsCollection.doc(attractionId).update({
      'averageRating': averageRatingWithOneDecimal, // Convert to string before storing
    });
    context.read<AttractionsBlocs>().add(AverageRatingEvent(averageRatingWithOneDecimal));
  }

  Future<void> addFavorite(BuildContext context, String userName, String userId, Attraction attraction) async {
    final CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
    final String attractionId = attraction.attractionId;
    final String attractionName = attraction.name;
    final String imageUrl = attraction.imageUrl;

    try {
      //Create a document under the favourites collection with userId as the ID and add a creation time field
      final DocumentReference userDocRef = favoritesCollection.doc(userId);
      await userDocRef.set({
        'createTime': FieldValue.serverTimestamp(),
      });

      final CollectionReference attractionsCollection = userDocRef.collection('attractions');
      //Create documents under the attractions subcollection with attractionId as the ID and store the data
      final DocumentReference attractionDocRef = attractionsCollection.doc(attractionId);
      await attractionDocRef.set({
        'name': attractionName,
        'imageUrl': imageUrl,
        'userName': userName,
        'favoriteTime': FieldValue.serverTimestamp(),
        'isFavorite': true,
      });
    } catch (error) {
      toastInfo(msg:'Error adding attraction to favorites: $error');
    }
  }

  Future<void> removeFavorite(BuildContext context, String userId, String attractionId) async {
    final CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
    final CollectionReference userFavoritesCollection = favoritesCollection.doc(userId).collection('attractions');

    try {
      await userFavoritesCollection.doc(attractionId).delete();
    } catch (error) {
      toastInfo(msg:'Error deleting attraction document from favorites: $error');
    }
  }

  Future<void> isFavorite(BuildContext context, String userId, String attractionId) async {
    final CollectionReference favoritesCollection = FirebaseHelper.favoritesCollection;
    final CollectionReference userFavoritesCollection = favoritesCollection.doc(userId).collection('attractions');

    try {
      final DocumentSnapshot documentSnapshot = await userFavoritesCollection.doc(attractionId).get();
      context.read<AttractionsBlocs>().add(IsFavoriteEvent(documentSnapshot.exists));
    } catch (error) {
      toastInfo(msg: 'Error checking if attraction is favorite: $error');
    }
  }

}