import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:dino_lab/presentation/home/home_bloc/home_bloc.dart';
import 'package:dino_lab/presentation/home/home_screen_content_bulder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: get<HomeBloc>()
            ..add(
              HomeEvent.getUserProfile(),
            ),
        ),
        BlocProvider.value(
          value: get<AuthBloc>(),
        ),
      ],
      child: const HomeScreenContentBuilder(),
    );
  }
}


