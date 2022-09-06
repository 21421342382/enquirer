class CreateReviewRequest {
  CreateReviewRequest({
    required this.reviewText,
    required this.stars,
    required this.memberId,
    required this.applicationId,
  });

  String reviewText;
  String stars;
  String memberId;
  String applicationId;

  Map<String, dynamic> toJson() {
    return {
      "review_text": reviewText,
      "stars": stars,
      "member_id": memberId,
      "application_id": applicationId,
    };
  }
}
