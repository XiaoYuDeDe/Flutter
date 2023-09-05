import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/pages/favorite/favorites_controller.dart';
import '../../common/themes/colors.dart';
import '../../common/widgets/common_widgets.dart';
import '../../entities/favorite.dart';
import '../../common/global/global.dart';
import 'bloc/favorites_blocs.dart';
import 'bloc/favorites_events.dart';
import 'bloc/favorites_states.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late String userId;

  @override
  void initState(){
    super.initState();
    final userInfo = Global.storageService.getUserInfo();
    userId = userInfo["userId"];
    FavoritesController(context: context).getFavoriteAttractions(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBlocs, FavoritesStates>(
        builder: (context, state){
          return Scaffold(
            appBar:commonAppBarWidget("Favorites", titleColor: AppColors.appBarColor),
            body: ListView.builder(
              itemCount: state.favoritesResult.length,
              itemBuilder: (context, index) {
                final favorite = state.favoritesResult[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        favorite.attractionImgUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(favorite.attractionName),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: AppColors.iconColor,
                    onPressed: () async {
                      //remove favorites from database
                      await FavoritesController(context: context).removeFavoriteAttraction(userId, favorite.favoriteId);
                      //remove favorite from local list
                      List<Favorite> currentFavorites = List.from(state.favoritesResult)..removeAt(index);
                      context.read<FavoritesBlocs>().add(FavoritesResultEvent(currentFavorites));
                    },
                  ),
                );
              },
            ),
          );
        }
    );
  }
}
