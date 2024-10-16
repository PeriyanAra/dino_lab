import 'package:flutter/material.dart';

class DinoLabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DinoLabAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  final Widget? title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0);
}
