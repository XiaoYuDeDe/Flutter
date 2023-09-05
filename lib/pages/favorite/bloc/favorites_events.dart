import '../../../entities/favorite.dart';

abstract class FavoritesEvents{
  const FavoritesEvents();
}

class FavoritesResultEvent extends FavoritesEvents{
  final List<Favorite> favoritesResult;
  const FavoritesResultEvent(this.favoritesResult);
}
