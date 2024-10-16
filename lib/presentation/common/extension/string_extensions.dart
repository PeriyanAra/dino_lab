extension StringExtensions on String? {
  String? defaultInputValidator() {
    if (this == null) {
      return 'This field must be not empty';
    } else if (this!.isEmpty) {
      return 'This field must be at least 1 character long';
    } else if (this!.length > 50) {
      return 'This field must not exceed 50 characters';
    }

    return null;
  }
}
