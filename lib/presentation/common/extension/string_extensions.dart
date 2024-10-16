import 'package:easy_localization/easy_localization.dart';

extension StringExtensions on String? {
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
}
