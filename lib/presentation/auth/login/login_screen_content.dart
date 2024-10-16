import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/auth/widgets/input_filed_section.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  late final TextEditingController passwordController;
  late final TextEditingController loginController;
  late final OverlayLoaderHelper _overlayLoaderHelper;
  late final GlobalKey<FormState> _loginFromKey;
  bool _showRemoteError = false;

  @override
  void initState() {
    super.initState();

    loginController = TextEditingController();
    passwordController = TextEditingController();
    _overlayLoaderHelper = OverlayLoaderHelper();
    _loginFromKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: authScreensTheme.contentPadding,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthLoadingState():
                  _overlayLoaderHelper.show(context);
                case AuthLoadedState():
                  _overlayLoaderHelper.hide();
                  context.router.replaceAll([PageRouteInfo('authenticated')]);
                case AuthErrorState():
                  _showRemoteError = true;
                  _overlayLoaderHelper.hide();
                default:
                  _overlayLoaderHelper.hide();
              }
            },
            child: Form(
              key: _loginFromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HBox(height: authScreensTheme.heightSmall),
                  Text(
                    'login'.tr(),
                    style: authScreensTheme.titleTextStyle,
                  ),
                  HBox(height: authScreensTheme.heightMedium),
                  InputFiledSection(
                    controller: loginController,
                    hintText: 'email'.tr(),
                    title: 'email'.tr(),
                    validator: (text) => text?.emailInputValidator(),
                    onChanged: _onChanged,
                  ),
                  HBox(height: authScreensTheme.heightSmall),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return InputFiledSection(
                        controller: passwordController,
                        title: 'password'.tr(),
                        hintText: 'password'.tr(),
                        isPasswordField: true,
                        validator: (text) => text.defaultInputValidator(),
                        errorText: _showRemoteError
                            ? (state is AuthErrorState
                                ? state.errorMessage
                                : null)
                            : null,
                        onChanged: _onChanged,
                      );
                    },
                  ),
                  HBox(height: authScreensTheme.heightSmall),
                  SizedBox(
                    width: double.infinity,
                    height: authScreensTheme.heightLarge,
                    child: PrimaryButton(
                      onTap: _onLoginTap,
                      text: 'login'.tr().toUpperCase(),
                    ),
                  ),
                  HBox(height: authScreensTheme.heightSmall),
                  SizedBox(
                    width: double.infinity,
                    height: authScreensTheme.heightLarge,
                    child: SecondaryButton(
                      onTap: () => context.router.replaceAll(
                        [RegistrationRoute()],
                      ),
                      text: 'signUp'.tr().toUpperCase(),
                    ),
                  ),
                  HBox(height: authScreensTheme.heightSmall),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginTap() {
    final isValid = _loginFromKey.currentState?.validate() ?? false;

    if (!isValid) return;

    context.read<AuthBloc>().add(
          AuthEvent.login(
            email: loginController.text,
            password: passwordController.text,
          ),
        );
  }

  void _onChanged(String _) => setState(() {
        _showRemoteError = false;
      });
}
