class AuthException with Exception {
  final String message;
  final int? code;
  AuthException({
    required this.message,
    required this.code,
  });
}
