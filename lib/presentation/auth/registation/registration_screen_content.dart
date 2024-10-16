import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/auth/widgets/input_filed_section.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/router/app_router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreenContent extends StatefulWidget {
  const RegistrationScreenContent({super.key});

  @override
  State<RegistrationScreenContent> createState() =>
      _RegistrationScreenContentState();
}

class _RegistrationScreenContentState extends State<RegistrationScreenContent> {
  late final TextEditingController _passwordController;
  late final TextEditingController _loginController;
  late final TextEditingController _nameController;
  late final OverlayLoaderHelper _overlayLoaderHelper;
  late final GlobalKey<FormState> _registerFromKey;
  bool _showRemoteError = false;
  bool _isValid = true;
  bool _isNeedClean = false;

  @override
  void initState() {
    super.initState();

    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _overlayLoaderHelper = OverlayLoaderHelper();
    _registerFromKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: isKeyboardVisible
              ? authScreensTheme.contentPaddingWhenKeyboardVisible
              : authScreensTheme.contentPadding,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthLoadingState():
                  _overlayLoaderHelper.show(context);
                case AuthLoadedState():
                  _overlayLoaderHelper.hide();
                  context.router.replaceAll([PageRouteInfo('authenticated')]);
                case AuthErrorState():
                  setState(() {
                    _showRemoteError = true;
                  });
                  _overlayLoaderHelper.hide();
                default:
                  _overlayLoaderHelper.hide();
              }
            },
            child: Form(
              key: _registerFromKey,
              child: SingleChildScrollView(
                physics: isKeyboardVisible
                    ? ClampingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: isKeyboardVisible
                      ? null
                      : MediaQuery.of(context).size.height,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HBox(height: authScreensTheme.heightSmall),
                          Text(
                            'signUp'.tr(),
                            style: authScreensTheme.titleTextStyle,
                          ),
                          HBox(height: authScreensTheme.heightMedium),
                          InputFiledSection(
                            controller: _loginController,
                            hintText: 'email'.tr(),
                            title: 'email'.tr(),
                            validator: (text) => text.emailInputValidator(),
                            onChanged: _onChanged,
                            errorText: _showRemoteError
                                ? (state is AuthErrorState ? '' : null)
                                : null,
                          ),
                          HBox(height: authScreensTheme.heightSmall),
                          InputFiledSection(
                            controller: _passwordController,
                            title: 'password'.tr(),
                            hintText: 'password'.tr(),
                            isPasswordField: true,
                            validator: (text) => text.defaultInputValidator(),
                            errorText: _showRemoteError
                                ? (state is AuthErrorState ? '' : null)
                                : null,
                            onChanged: _onChanged,
                          ),
                          HBox(height: authScreensTheme.heightSmall),
                          InputFiledSection(
                            controller: _nameController,
                            title: 'name'.tr(),
                            hintText: 'name'.tr(),
                            validator: (text) => text.defaultInputValidator(),
                            errorText: _showRemoteError
                                ? (state is AuthErrorState
                                    ? state.errorMessage
                                    : null)
                                : null,
                            onChanged: _onChanged,
                          ),
                          HBox(height: authScreensTheme.heightSmall),
                          SizedBox(
                            width: double.infinity,
                            height: authScreensTheme.heightLarge,
                            child: PrimaryButton(
                              onTap: _isValid && !_showRemoteError
                                  ? _onSignUpTap
                                  : null,
                              text: 'signUp'.tr().toUpperCase(),
                            ),
                          ),
                          HBox(height: authScreensTheme.heightSmall),
                          SizedBox(
                            width: double.infinity,
                            height: authScreensTheme.heightLarge,
                            child: SecondaryButton(
                              onTap: () =>
                                  context.router.replaceAll([LoginRoute()]),
                              text: 'login'.tr().toUpperCase(),
                            ),
                          ),
                          HBox(height: authScreensTheme.heightSmall),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChanged(String _) {
    Future.delayed(Duration(milliseconds: 10)).whenComplete(() {
      if (_isNeedClean) {
        _registerFromKey.currentState?.reset();

        setState(() {
          _isNeedClean = false;
        });
      }
    });

    setState(() {
      _showRemoteError = false;
      _isValid = true;
    });
  }

  void _onSignUpTap() {
    _isValid = _registerFromKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();
    setState(() {
      _isNeedClean = true;
    });

    if (!_isValid) return;

    context.read<AuthBloc>().add(
          AuthEvent.register(
            email: _loginController.text,
            password: _passwordController.text,
            name: _nameController.text,
          ),
        );
  }
}
