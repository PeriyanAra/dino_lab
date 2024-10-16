import 'package:dino_lab/presentation/common/theme/secondary_button_theme.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SecondaryButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryButtonTheme = SecondaryButtonTheme.of(context);

    return ElevatedButton(
      onPressed: onTap,
      style: secondaryButtonTheme.buttonStyle,
      child: Text(
        text,
        style: secondaryButtonTheme.textStyle,
      ),
    );
  }
}
