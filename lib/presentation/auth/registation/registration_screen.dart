import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/auth/registation/registration_screen_content.dart';
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
