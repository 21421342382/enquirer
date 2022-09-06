class Profile {
  Profile({
    required this.about,
    required this.acsReferenceNumber,
    required this.address,
    required this.city,
    required this.companyContact,
    required this.companyLogo,
    required this.contact,
    required this.createdAt,
    required this.enquirerId,
    required this.id,
    required this.name,
    required this.postalCode,
    required this.registrationNumber,
    required this.updatedAt,
  });

  String? about;
  String? acsReferenceNumber;
  String? address;
  String? city;
  String companyContact;
  String companyLogo;
  String contact;
  DateTime createdAt;
  int enquirerId;
  String id;
  String name;
  String? postalCode;
  String? registrationNumber;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      about: json["about"],
      acsReferenceNumber: json["acs_reference_number"],
      address: json["address"],
      city: json["city"],
      companyContact: json["company_contact"],
      companyLogo: json["company_logo"],
      contact: json["contact"],
      createdAt: DateTime.parse(json["created_at"]),
      enquirerId: json["enquirer_id"],
      id: json["id"],
      name: json["name"],
      postalCode: json["postal_code"],
      registrationNumber: json["registration_number"],
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
