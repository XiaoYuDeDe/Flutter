class Review {
  final String reviewsId;
  final String username;
  final String content;
  final double rating;
  final DateTime commentTime;

  Review({
    required this.reviewsId,
    required this.username,
    required this.content,
    required this.rating,
    required this.commentTime,
  });
}