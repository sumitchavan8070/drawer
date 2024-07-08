class GenericValidator {
  static String? required({
    required String? value,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return message ?? "Required";
    }
    return null;
  }

  static String? regexMatch({
    required String? value,
    required RegExp regex,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return message ?? "Required";
    }

    if (regex.hasMatch(value) == false) {
      return message ?? "Not Match";
    }
    return null;
  }

  static String? checkLength({
    required String? value,
    required int length,
    String? message,
  }) {
    if (value == null || value.isEmpty == true) {
      return null;
    }
    if (value.length < length) {
      return message ?? "Invalid Length";
    }
    return null;
  }
}
