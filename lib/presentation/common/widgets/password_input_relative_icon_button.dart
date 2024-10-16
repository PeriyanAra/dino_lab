import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordInputRelativeIconButton extends StatefulWidget {
  const PasswordInputRelativeIconButton({super.key});

  @override
  State<PasswordInputRelativeIconButton> createState() =>
      _PasswordInputRelativeIconButtonState();

}

class _PasswordInputRelativeIconButtonState
    extends State<PasswordInputRelativeIconButton> {
  bool isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      ),
    );
  }
}
