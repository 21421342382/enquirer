class KCard {
  KCard(
      {required this.cardType,
      required this.cardNumber,
      required this.cvv,
      required this.expiryDate,
      required this.id,
      required this.nameOnCard,
      required this.status});

  final bool status;
  final String nameOnCard;
  final int id;
  final String expiryDate;
  final String cardNumber;
  final String cvv;
  final String cardType;

  factory KCard.fromJson(Map<String, dynamic> json) {
    return KCard(
        cardType: json['card_'],
        cardNumber: json['card_number'],
        cvv: json['cvv'],
        expiryDate: json['expiry_date'],
        id: json['id'],
        nameOnCard: json['name_on_card'],
        status: json['status']);
  }
}
