import '../../../entities/review.dart';

class AttractionsStates{
  final double rating;
  final String comment;
  final List<Review> reviewsResult;
  final double averageRating;
  final bool isFavorite;

  const AttractionsStates({
    this.rating=0.0,
    this.comment="",
    this.reviewsResult=const[],
    this.averageRating=0.0,
    this.isFavorite=false
  });

  AttractionsStates copyWith({
    double? rating,
    String? comment,
    List<Review>? reviewsResult,
    double?averageRating,
    bool? isFavorite
  }){
    return AttractionsStates(
        rating:rating??this.rating,
        comment:comment??this.comment,
        reviewsResult:reviewsResult??this.reviewsResult,
        averageRating:averageRating??this.averageRating,
        isFavorite:isFavorite??this.isFavorite
    );
  }
}