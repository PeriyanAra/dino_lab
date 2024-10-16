import 'package:dino_lab/presentation/common/index.dart';
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
            ? _HideIcon(
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

class _HideIcon extends StatefulWidget {
  const _HideIcon({
    required this.onTap,
    required this.isRevealed,
  });

  final VoidCallback onTap;
  final bool isRevealed;

  @override
  State<_HideIcon> createState() => _HideIconState();
}

class _HideIconState extends State<_HideIcon> {
  @override
  Widget build(BuildContext context) {
    final inputTheme = DinoLabInputFieldTheme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: SvgPicture.asset(
        widget.isRevealed
            ? 'assets/icons/ic_password_obfuscate_visible.svg'
            : 'assets/icons/ic_password_obfuscate_invisible.svg',
        width: inputTheme.hideIconSize,
        height: inputTheme.hideIconSize,
        fit: BoxFit.scaleDown,
        colorFilter: inputTheme.hideIconColorFilter,
      ),
    );
  }
}
