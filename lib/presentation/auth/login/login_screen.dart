import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/auth/widgets/input_filed_section.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: get<AuthBloc>(),
      child: LoginScreenContent(),
    );
  }
}

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
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthLoadingState():
                  _overlayLoaderHelper.show(context);
                case AuthLoadedState():
                  _overlayLoaderHelper.hide();
                  context.router.replaceAll([HomeRoute()]);
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
                  HBox(height: 20.0),
                  Text(
                    'Log in',
                    style: authScreensTheme.titleTextStyle,
                  ),
                  HBox(height: 40.0),
                  InputFiledSection(
                    controller: loginController,
                    hintText: 'Login',
                    title: 'Login, email or mobile number',
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
                        controller: passwordController,
                        title: 'Password',
                        hintText: 'Password',
                        isPasswordField: true,
                        validator: (text) => text.defaultInputValidator(),
                        errorText: _showRemoteError
                            ? (state is AuthErrorState
                                ? state.errorMessage
                                : null)
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _showRemoteError = false;
                          });
                        },
                      );
                    },
                  ),
                  HBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: PrimaryButton(
                      onTap: _onLoginTap,
                      text: 'LOG IN',
                    ),
                  ),
                  HBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: SecondaryButton(
                      onTap: () => context.router.push(
                        RegistrationRoute(),
                      ),
                      text: 'SIGN UP',
                    ),
                  ),
                  HBox(height: 20.0),
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
}
