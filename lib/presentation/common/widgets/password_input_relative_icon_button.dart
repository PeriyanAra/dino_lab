import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordInputRelativeIconButton extends StatefulWidget {
  const PasswordInputRelativeIconButton({
    super.key,
    required this.onTap,
    required this.isRevealed,
  });

  final VoidCallback onTap;
  final bool isRevealed;

  @override
  State<PasswordInputRelativeIconButton> createState() =>
      PasswordInputRelativeIconButtonState();
}

class PasswordInputRelativeIconButtonState
    extends State<PasswordInputRelativeIconButton> {
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
