import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final primaryButtonTheme = PrimaryButtonTheme.of(context);

    return ElevatedButton(
      onPressed: onTap,
      style: primaryButtonTheme.buttonStyle,
      child: Text(
        text,
        style: primaryButtonTheme.textStyle,
      ),
    );
  }
}
