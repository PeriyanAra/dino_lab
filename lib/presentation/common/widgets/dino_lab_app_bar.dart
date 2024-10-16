import 'package:dino_lab/presentation/common/theme/dino_lab_app_bar_theme.dart';
import 'package:flutter/material.dart';

class DinoLabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DinoLabAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = DinoLabAppBarTheme.of(context);

    return AppBar(
      title: Text(
        title,
        style: appBarTheme.titleTextStyle,
      ),
      backgroundColor: appBarTheme.backgroundColor,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
