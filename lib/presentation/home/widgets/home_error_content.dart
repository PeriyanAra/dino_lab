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
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
