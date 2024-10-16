import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/theme/index.dart';
import 'package:dino_lab/presentation/auth/widgets/input_filed_section.dart';
import 'package:dino_lab/presentation/common/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: get<AuthBloc>(),
      child: RegistrationScreenContent(),
    );
  }
}

class RegistrationScreenContent extends StatefulWidget {
  const RegistrationScreenContent({super.key});

  @override
  State<RegistrationScreenContent> createState() =>
      _RegistrationScreenContentState();
}

class _RegistrationScreenContentState extends State<RegistrationScreenContent> {
  late final TextEditingController passwordController;
  late final TextEditingController loginController;
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    loginController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authScreensTheme = AuthScreensTheme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment(1, 0),
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
              hintText: 'Login',
              title: 'Login, email or mobile number',
              controller: loginController,
              errorText: validateText(nameController.text),
            ),
            HBox(height: 20.0),
            InputFiledSection(
              title: 'Password',
              hintText: 'Password',
              controller: passwordController,
              isPasswordField: true,
              errorText: validateText(nameController.text),
            ),
            HBox(height: 20.0),
            InputFiledSection(
              controller: nameController,
              title: 'Name',
              hintText: 'Name',
              isPasswordField: true,
              errorText: validateText(nameController.text),
            ),
            HBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: PrimaryButton(
                onTap: () {},
                text: 'SIGN UP',
              ),
            ),
          ],
        ),
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
