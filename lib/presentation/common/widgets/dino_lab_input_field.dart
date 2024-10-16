import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';

class DinoLabInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPasswordField;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const DinoLabInputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isPasswordField = false,
    this.errorText,
    this.validator,
    this.onChanged,
  });

  @override
  State<DinoLabInputField> createState() => _DinoLabInputFieldState();
}

class _DinoLabInputFieldState extends State<DinoLabInputField> {
  bool isRevealed = true;

  @override
  Widget build(BuildContext context) {
    final inputTheme = DinoLabInputFieldTheme.of(context);

    return TextFormField(
      controller: widget.textEditingController,
      style: inputTheme.primaryTextStyle,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        enabledBorder: inputTheme.enabledBorder,
        focusedBorder: inputTheme.focusedBorder,
        errorBorder: inputTheme.errorBorder,
        focusedErrorBorder: inputTheme.focusedBorder,
        errorText: widget.errorText,
        suffixIcon: widget.isPasswordField
            ? PasswordInputRelativeIconButton(
                onTap: () {
                  setState(() {
                    isRevealed = !isRevealed;
                  });
                },
                isRevealed: isRevealed,
              )
            : null,
        hintStyle: inputTheme.hintTextStyle,
      ),
      obscureText: widget.isPasswordField && isRevealed,
    );
  }
}
