import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbp_currency_checker/core/di/injectable.dart';
import 'package:nbp_currency_checker/presentation/pages/home/home_page_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello world'),
      ),
      body: BlocProvider(
        create: (context) => getIt<HomePageCubit>(),
        child: const Text('Hello world'),
      ),
    );
  }
}
