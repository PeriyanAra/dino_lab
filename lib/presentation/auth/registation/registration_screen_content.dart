import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/auth/widgets/input_filed_section.dart';
import 'package:dino_lab/presentation/common/index.dart';
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
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
              key: _registerFromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HBox(height: 20.0),
                  Text(
                    'Log in',
                    style: authScreensTheme.titleTextStyle,
                  ),
                  HBox(height: 40.0),
                  InputFiledSection(
                    controller: _loginController,
                    hintText: 'Login',
                    title: 'Login, email or mobile number',
                    validator: (text) => text.emailInputValidator(),
                    onChanged: (value) {
                      setState(() {
                        _showRemoteError = false;
                      });
                    },
                  ),
                  HBox(height: 20.0),
                  InputFiledSection(
                    controller: _passwordController,
                    title: 'Password',
                    hintText: 'Password',
                    isPasswordField: true,
                    validator: (text) => text.defaultInputValidator(),
                    onChanged: (value) {
                      setState(() {
                        _showRemoteError = false;
                      });
                    },
                  ),
                  HBox(height: 20.0),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return InputFiledSection(
                        controller: _nameController,
                        title: 'Name',
                        hintText: 'Name',
                        validator: (text) => text.defaultInputValidator(),
                        errorText: _showRemoteError
                            ? (state is AuthErrorState
                                ? state.errorMessage
                                : null)
                            : null,
                      );
                    },
                  ),
                  HBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: PrimaryButton(
                      onTap: _onSignUpTap,
                      text: 'SIGN UP',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUpTap() {
    final isValid = _registerFromKey.currentState?.validate() ?? false;

    if (!isValid) return;

    context.read<AuthBloc>().add(
          AuthEvent.register(
            email: _loginController.text,
            password: _passwordController.text,
            name: _nameController.text,
          ),
        );
  }
}
