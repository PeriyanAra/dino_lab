import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/home/theme/home_screen_theme.dart';
import 'package:dino_lab/presentation/home/view_models/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeLoadedContent extends StatelessWidget {
  final ProfileViewModel profileViewModel;

  const HomeLoadedContent({
    super.key,
    required this.profileViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final homeScreenTheme = HomeScreenTheme.of(context);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HBox(height: homeScreenTheme.spaceBetweenAvatarAndUserName),
              UserAvatar(
                imageUrl: profileViewModel.avatar,
              ),
              HBox(height: homeScreenTheme.spaceBetweenAvatarAndUserName),
              Text(
                profileViewModel.name,
                style: homeScreenTheme.userNameTextStyle,
              ),
              Text(
                profileViewModel.email,
                style: homeScreenTheme.userEmailTextStyle,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: homeScreenTheme.logoutButtonWidth,
              height: homeScreenTheme.logoutButtonHeight,
              child: PrimaryButton(
                onTap: () {},
                text: 'logOut'.tr().toUpperCase(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
