import '../../../entities/favorite.dart';

class FavoritesStates{
  final List<Favorite> favoritesResult;

  const FavoritesStates({
    this.favoritesResult=const[]
  });

  FavoritesStates copyWith({
    List<Favorite>? favoritesResult
  }){
    return FavoritesStates(
        favoritesResult:favoritesResult??this.favoritesResult
    );
  }
}