import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DinoLabInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPasswordField;
  final String? errorText;

  const DinoLabInputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isPasswordField = false,
    this.errorText,
  });

  @override
  State<DinoLabInputField> createState() => _DinoLabInputFieldState();
}

class _DinoLabInputFieldState extends State<DinoLabInputField> {
  bool isRevealed = true;

  @override
  Widget build(BuildContext context) {
    final inputTheme = DinoLabInputFieldTheme.of(context);

    return TextField(
      controller: widget.textEditingController,
      style: inputTheme.primaryTextStyle,
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
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      obscureText: widget.isPasswordField && isRevealed,
    );
  }
}
