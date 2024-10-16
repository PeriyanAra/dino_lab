import 'package:dino_lab/presentation/home/view_models/index.dart';
import 'package:flutter/material.dart';

class HomeLoadedContent extends StatelessWidget {
  final ProfileViewModel homeScreenViewModel;

  const HomeLoadedContent({
    super.key,
    required this.homeScreenViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
