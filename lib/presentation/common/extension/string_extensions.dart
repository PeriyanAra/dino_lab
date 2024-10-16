import 'package:easy_localization/easy_localization.dart';

extension NullableStringExtensions on String? {
  String? defaultInputValidator() {
    if (this == null) {
      return 'nullField'.tr();
    } else if (this!.isEmpty) {
      return 'emptyField'.tr();
    } else if (this!.length > 50) {
      return 'moreThen50CharacterField'.tr();
    }

    return null;
  }

  String? emailInputValidator() {
    if (this == null) {
      return 'nullField'.tr();
    } else if (this!.isEmpty) {
      return 'emptyField'.tr();
    } else if (this!.length > 50) {
      return 'moreThen50CharacterField'.tr();
    } else {
      final emailValidationRegExp = RegExp(r'.+@.+\..+');
      final isValid = emailValidationRegExp.hasMatch(this!);

      if (!isValid) return 'emailFormatIncorrect'.tr();
    }

    return null;
  }
}
