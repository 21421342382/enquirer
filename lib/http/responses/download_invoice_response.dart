class DownloadInvoiceResponse {
  DownloadInvoiceResponse({
    required this.fileLink,
    required this.message,
  });

  String fileLink;
  String message;

  factory DownloadInvoiceResponse.fromJson(Map<String, dynamic> json) {
    return DownloadInvoiceResponse(
      fileLink: json["file_link"],
      message: json["message"],
    );
  }
}
