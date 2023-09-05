import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference get attractionsCollection => firestore.collection('attraction');

  static CollectionReference get categoriesCollection => firestore.collection('category');

  static CollectionReference get reviewsCollection => firestore.collection('review');

  static CollectionReference get favoritesCollection => firestore.collection('favorite');
}