import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/home/theme/home_screen_theme.dart';
import 'package:dino_lab/presentation/home/view_models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLoadedContent extends StatefulWidget {
  final ProfileViewModel profileViewModel;

  const HomeLoadedContent({
    super.key,
    required this.profileViewModel,
  });

  @override
  State<HomeLoadedContent> createState() => _HomeLoadedContentState();
}

class _HomeLoadedContentState extends State<HomeLoadedContent> {
  late final OverlayLoaderHelper _overlayLoaderHelper;

  @override
  void initState() {
    super.initState();

    _overlayLoaderHelper = OverlayLoaderHelper();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenTheme = HomeScreenTheme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoadingState():
            _overlayLoaderHelper.show(context);
          case AuthLoadedState():
            _overlayLoaderHelper.hide();
            context.router.replaceAll([PageRouteInfo('unauthenticated')]);
          case AuthErrorState(:final errorMessage):
            _overlayLoaderHelper.hide();
            DialogHelper.show(
              context,
              title: errorMessage ?? 'aaaa',
              buttonText: "Ok",
            );
          default:
            _overlayLoaderHelper.hide();
        }
      },
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                HBox(height: homeScreenTheme.spaceBetweenAvatarAndUserName),
                UserAvatar(
                  imageUrl: widget.profileViewModel.avatar,
                ),
                HBox(height: homeScreenTheme.spaceBetweenAvatarAndUserName),
                Text(
                  widget.profileViewModel.name,
                  style: homeScreenTheme.userNameTextStyle,
                ),
                Text(
                  widget.profileViewModel.email,
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
                  onTap: () => context.read<AuthBloc>().add(
                        AuthEvent.logout(),
                      ),
                  text: 'LOG OUT',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
