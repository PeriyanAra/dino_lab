extension NullableStringExtensions on String? {
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

  String? emailInputValidator() {
    if (this == null) {
      return 'This field must be not empty';
    } else if (this!.isEmpty) {
      return 'This field must be at least 1 character long';
    } else if (this!.length > 50) {
      return 'This field must not exceed 50 characters';
    } else {
      final emailValidationRegExp = RegExp(r'.+@.+\..+');
      final isValid = emailValidationRegExp.hasMatch(this!);

      if (!isValid) return 'Email is incorrect';
    }

    return null;
  }
}
