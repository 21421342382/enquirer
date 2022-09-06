class StripeResponse {
  final String url;

  StripeResponse({required this.url});

  factory StripeResponse.fromJson(Map<String, dynamic> json) =>
      StripeResponse(url: json["session"]['url']);
}
