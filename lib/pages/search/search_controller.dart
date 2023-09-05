import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../common/utils/firebase_helper.dart';
import '../../entities/attraction.dart';
import 'bloc/bloc/search_blocs.dart';
import 'bloc/bloc/search_events.dart';

class SearchPageController{
  final BuildContext context;
  final CollectionReference attractionsCollection = FirebaseHelper.attractionsCollection;

  SearchPageController({required this.context});

  Future<void> searchAttractions(String searchText) async {
    if (searchText.isEmpty) {
      context.read<SearchBlocs>().add(SearchResultsEvent([]));
      return;
    }

    final String lowercaseSearchText = searchText.toLowerCase();

    final QuerySnapshot querySnapshot = await attractionsCollection.get();

    final attractions = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Attraction(
        attractionId: doc.id,
        categoryId: data['categoryId'],
        name: data['name'],
        city: data['city'],
        description: data['description'],
        averageRating: data['averageRating'].toDouble(),
        imageUrl: data['imageUrl'],
        createTime: data['createTime'].toDate()
      );
    }).toList();

    final List<Attraction> results = [];

    attractions.forEach((attraction) {
      final String name = attraction.name.toLowerCase();
      final String city = attraction.city.toLowerCase();

      if (name.contains(lowercaseSearchText) || city.contains(lowercaseSearchText)) {
        results.add(attraction);
      }
    });
    context.read<SearchBlocs>().add(SearchResultsEvent(results));
  }

  Future<void> getFilteredAttractions(String searchText, List<String> categories) async {

    final List<QuerySnapshot> categoryQueryResults = await Future.wait(
      categories.map((categoryId) {
        return attractionsCollection.where('categoryId', isEqualTo: categoryId).get();
      }),
    );

    final List<Attraction> filteredResults = [];

    for (final querySnapshot in categoryQueryResults) {
      querySnapshot.docs.forEach((doc) {
        final attraction = doc.data() as Map<String, dynamic>;
        final Attraction filteredAttraction = Attraction(
          attractionId: doc.id,
          categoryId: attraction['categoryId'],
          name: attraction['name'],
          city: attraction['city'],
          description: attraction['description'],
          averageRating: attraction['averageRating'].toDouble(),
          imageUrl: attraction['imageUrl'],
          createTime: attraction['createTime'].toDate()
        );

        final String name = filteredAttraction.name.toLowerCase();
        final String city = filteredAttraction.city.toLowerCase();

        if (name.contains(searchText.toLowerCase()) || city.contains(searchText.toLowerCase())) {
          filteredResults.add(filteredAttraction);
        }
      });
    }
    context.read<SearchBlocs>().add(SearchResultsEvent(filteredResults));
  }

}