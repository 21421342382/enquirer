import 'package:arcopen_enquirer/core/models/invoice_details.dart';

class InvoiceDetailsResponse {
  InvoiceDetailsResponse({
    required this.businessName,
    required this.invoiceDetails,
  });

  String businessName;
  InvoiceDetails invoiceDetails;

  factory InvoiceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailsResponse(
      businessName: json["business_name"],
      invoiceDetails: InvoiceDetails.fromJson(json["invoice_details"]),
    );
  }
}
