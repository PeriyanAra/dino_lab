import 'package:auto_route/auto_route.dart';
import 'package:dino_lab/app/app_bootstrapper.dart';
import 'package:dino_lab/presentation/home/home_bloc/home_bloc.dart';
import 'package:dino_lab/presentation/home/widgets/home_error_content.dart';
import 'package:dino_lab/presentation/home/widgets/home_loaded_content.dart';
import 'package:dino_lab/presentation/home/widgets/home_loading_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: get<HomeBloc>()
        ..add(
          HomeEvent.getUserProfile(),
        ),
      child: const HomeScreenContentBuilder(),
    );
  }
}

class HomeScreenContentBuilder extends StatelessWidget {
  const HomeScreenContentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeLoadedState(:final profileViewModel) => HomeLoadedContent(
                homeScreenViewModel: profileViewModel,
              ),
            HomeErrorState(:final errorMessage) => HomeErrorContent(
                errorMessage: errorMessage,
              ),
            _ => const HomeLoadingContent(),
          };
        },
      ),
    );
  }
}
