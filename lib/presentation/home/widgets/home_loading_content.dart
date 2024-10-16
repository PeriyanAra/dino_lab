import 'package:flutter/material.dart';

class HomeLoadingContent extends StatelessWidget {
  const HomeLoadingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
