import '../../../entities/review.dart';

abstract class AttractionsEvents{
  const AttractionsEvents();
}

class RatingChangedEvent extends AttractionsEvents{
  final double rating;
  const RatingChangedEvent(this.rating);
}

class CommentEvent extends AttractionsEvents{
  final String comment;
  const CommentEvent(this.comment);
}

class ReviewsResultEvent extends AttractionsEvents{
  final List<Review> reviewsResult;
  const ReviewsResultEvent(this.reviewsResult);
}

class AverageRatingEvent extends AttractionsEvents{
  final double averageRating;
  const AverageRatingEvent(this.averageRating);
}

class IsFavoriteEvent extends AttractionsEvents{
  final bool isFavorite;
  const IsFavoriteEvent(this.isFavorite);
}