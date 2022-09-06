class RequestException implements Exception {
  final String? _message;

  RequestException(this._message);

  String get message => _message ?? "An unknown error occured. Please try again later.";

  @override
  String toString() {
    return _message ?? "Failed to load data. Pleasse try again later.";
  }
}
