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
  final _errors = <String, String?>{};
  late final OverlayLoaderHelper _overlayLoaderHelper;

  @override
  void initState() {
    super.initState();

    loginController = TextEditingController();
    passwordController = TextEditingController();
    _overlayLoaderHelper = OverlayLoaderHelper();
  }

  @override
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              _overlayLoaderHelper.show(context);
            } else {
              _overlayLoaderHelper.hide();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100.0,
                    ),
                  ),
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
                    errorText: _errors['login'],
                  ),
                  HBox(height: 20.0),
                  InputFiledSection(
                    controller: passwordController,
                    title: 'Password',
                    hintText: 'Password',
                    isPasswordField: true,
                    errorText: _errors['password'] ??
                        (state is AuthErrorState ? state.errorMessage : null),
                  ),
                  HBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: PrimaryButton(
                      onTap: onLoginTap,
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
            );
          },
        ),
      ),
    );
  }

  void onLoginTap() {
    final loginErrors = validateText(loginController.text);
    final passwordErrors = validateText(passwordController.text);

    _errors['login'] = loginErrors;
    _errors['password'] = passwordErrors;

    setState(() {});
    if (loginErrors != null || passwordErrors != null) return;

    context.read<AuthBloc>().add(
          AuthEvent.login(
            email: loginController.text,
            password: passwordController.text,
            onSuccess: () {
              _overlayLoaderHelper.hide();
            },
          ),
        );
  }

  String? validateText(String value) {
    if (value.isEmpty) {
      return 'Text must be at least 1 character long';
    } else if (value.length > 50) {
      return 'Text must not exceed 50 characters';
    }

    return null;
  }
}
