import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/firebase_helper.dart';
import '../../entities/attraction.dart';
import 'bloc/home_blocs.dart';
import 'bloc/home_events.dart';

class HomeController{
  final BuildContext context;

  const HomeController({required this.context});

  Future<void> fetchAttractions(bool isTop, bool isSort) async {
    final attractionsCollection = FirebaseHelper.attractionsCollection;
    final querySnapshot = await attractionsCollection.get();

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

    if(isSort){
      attractions.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    }
    if(isTop){
      context.read<HomeBlocs>().add(TopAttractionsEvents(attractions.take(3).toList()));
    }else{
      context.read<HomeBlocs>().add(AttractionListEvents(attractions));
    }
  }

}