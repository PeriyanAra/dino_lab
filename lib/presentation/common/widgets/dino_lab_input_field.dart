import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      validator:  widget.validator,
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
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    isRevealed = !isRevealed;
                  });
                },
                child: SvgPicture.asset(
                  isRevealed
                      ? 'assets/icons/ic_password_obfuscate_visible.svg'
                      : 'assets/icons/ic_password_obfuscate_invisible.svg',
                  width: 10.0,
                  height: 10.0,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    DinoLabColorsPalette.black35,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        hintStyle: inputTheme.hintTextStyle,
      ),
      obscureText: widget.isPasswordField && isRevealed,
    );
  }
}
