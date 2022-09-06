import 'package:arcopen_enquirer/core/models/k_card.dart';

class AddCardResponse {
  final KCard card;
  final String successMessage;

  AddCardResponse({required this.card, required this.successMessage});

  factory AddCardResponse.fromJson(Map<String, dynamic> json) {
    return AddCardResponse(card: KCard.fromJson(json['card']), successMessage: json['success']);
  }
}
