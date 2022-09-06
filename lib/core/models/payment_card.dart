class PaymentCard {
  PaymentCard({
    required this.cardNumber,
    required this.expirationMonth,
    required this.expirationYear,
  });

  String cardNumber;
  String expirationMonth;
  String expirationYear;

  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    return PaymentCard(
      cardNumber: json["cardNumber"],
      expirationMonth: json["expirationMonth"],
      expirationYear: json["expirationYear"],
    );
  }

  Map<String, dynamic> toJson() => {
        "cardNumber": cardNumber,
        "expirationMonth": expirationMonth,
        "expirationYear": expirationYear,
      };
}
