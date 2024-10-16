import 'package:dino_lab/presentation/home/theme/home_screen_theme.dart';
import 'package:flutter/material.dart';

class HomeErrorContent extends StatelessWidget {
  final String errorMessage;

  const HomeErrorContent({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: HomeScreenTheme.of(context).errorContentPadding,
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
