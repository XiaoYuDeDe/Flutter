class Favorite {
  final String favoriteId;
  final String attractionName;
  final String attractionImgUrl;
  final DateTime favoriteTime;
  final bool isFavorite;

  Favorite({
    required this.favoriteId,
    required this.attractionName,
    required this.attractionImgUrl,
    required this.favoriteTime,
    required this.isFavorite
  });
}