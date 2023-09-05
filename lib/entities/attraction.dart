class Attraction {
  final String attractionId;
  final String name;
  final String city;
  final String description;
  final double averageRating;
  final String imageUrl;
  final String categoryId;
  final DateTime createTime;

  Attraction({
    required this.attractionId,
    required this.name,
    required this.city,
    required this.description,
    required this.averageRating,
    required this.imageUrl,
    required this.categoryId,
    required this.createTime
  });
}