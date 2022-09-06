mixin ValidationMixin {
  String? validateRequired(
      {required String fieldName, required String? value}) {
    final String validationMessage = "The $fieldName field is required";
    if (value == null) return validationMessage;
    if (value.isEmpty) return validationMessage;
    return null;
  }

  String? validateEmail({required String fieldName, required String email}) {
    final String validationMessage = "The $fieldName is not a correct email";
    final RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(email)) return validationMessage;
    return null;
  }

  String? validateBadgeNumber(
      {required String fieldName, required String badgeNumber}) {
    final String validationMessage = "$fieldName is not a valid badge number";
    final RegExp badgeNumberRegExp =
        RegExp(r"[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}");
    if (!badgeNumberRegExp.hasMatch(badgeNumber)) return validationMessage;
    return null;
  }

  String? validateDate({required String fieldName, required String value}) {
    String validationMessage = "$fieldName is not a valid date";
    if (DateTime.tryParse(value) == null) return validationMessage;
    return null;
  }

  String? validateTime({required String fieldName, required String value}) {
    final String validationMessage = "$fieldName is not a valid time";
    final RegExp timeRegExp = RegExp(r"[0-9]{2}:[0-9]{2}");

    if (!timeRegExp.hasMatch(value) || value.isEmpty) return validationMessage;
    return null;
  }

  String? validateMinlength(
      {required String fieldName, required String value, int min = 1}) {
    final String validationMessage =
        "$fieldName must be at least $min characters";
    if (value.isEmpty || value.length < min) return validationMessage;
    return null;
  }

  String? validateValueEquals(
      {required String fieldName,
      required String value,
      required List<String> equalValues}) {
    final String validationMessage =
        "$fieldName must correspond to one of ${equalValues.join(" or ")}";
    if (!equalValues.map((e) => e.toLowerCase()).contains(value.toLowerCase()))
      return validationMessage;
    return null;
  }
}
