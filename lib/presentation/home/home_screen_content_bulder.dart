import 'package:dino_lab/presentation/common/index.dart';
import 'package:dino_lab/presentation/home/home_bloc/home_bloc.dart';
import 'package:dino_lab/presentation/home/widgets/home_error_content.dart';
import 'package:dino_lab/presentation/home/widgets/home_loaded_content.dart';
import 'package:dino_lab/presentation/home/widgets/home_loading_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenContentBuilder extends StatelessWidget {
  const HomeScreenContentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DinoLabAppBar(
        title: Text(
          'HomeScreen',
          style: DinoLabAppBarTheme.of(context).titleTextStyle,
        ),
        backgroundColor: DinoLabAppBarTheme.of(context).primaryBackgroundColor,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeLoadedState(:final profileViewModel) => HomeLoadedContent(
                profileViewModel: profileViewModel,
              ),
            HomeErrorState(:final errorMessage) => HomeErrorContent(
                errorMessage: errorMessage ?? 'Something went wrong',
              ),
            _ => const HomeLoadingContent(),
          };
        },
      ),
    );
  }
}
