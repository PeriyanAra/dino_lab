import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/theme/index.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static void show(
    BuildContext context, {
    required String title,
    required String buttonText,
    VoidCallback? onButtonTap,
  }) {
    final dinoLabTextTheme = DinoLabTextTheme.of(context);
    final dialogHelperTheme = DialogHelperTheme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: dialogHelperTheme.dialogInsetPadding,
          child: Container(
            width: double.infinity,
            decoration: dialogHelperTheme.dialogContentDecoration,
            padding: dialogHelperTheme.dialogContentPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: dinoLabTextTheme.displaySmall,
                ),
                HBox(height: dialogHelperTheme.dialogContentSpace),
                Align(
                  alignment: Alignment.bottomRight,
                  child: PrimaryButton(
                    onTap: onButtonTap ?? () => context.router.maybePop(),
                    text: buttonText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
