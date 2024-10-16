import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';

class InputFiledSection extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String title;
  final bool isPasswordField;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const InputFiledSection({
    super.key,
    required this.hintText,
    required this.title,
    required this.controller,
    this.isPasswordField = false,
    this.errorText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: authScreensTheme.subTitleTextStyle,
        ),
        HBox(height: 10.0),
        DinoLabInputField(
          textEditingController: controller,
          hintText: hintText,
          isPasswordField: isPasswordField,
          errorText: errorText,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
