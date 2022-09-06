import 'package:arcopen_enquirer/core/models/k_card.dart';

class CardResponse {
  CardResponse({required this.cards});

  List<KCard> cards;

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(cards: List<KCard>.from(json['cards'].map((e) => KCard.fromJson(e))));
}
