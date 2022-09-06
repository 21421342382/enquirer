class Dispute {
  Dispute({
    required this.createdOn,
    required this.description,
    required this.disputeType,
    required this.id,
    required this.status,
  });

  final String createdOn;
  final String description;
  final String disputeType;
  final int id;
  final String status;

  bool get active => status == "active";

  factory Dispute.fromJson(Map<String, dynamic> json) {
    return Dispute(
      createdOn: json['created_on'],
      description: json['description'],
      disputeType: json['dispute_type'],
      id: json['id'],
      status: json['status'],
    );
  }
}
