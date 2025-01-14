import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbp_currency_checker/core/log/bloc_logger.dart';
import 'package:nbp_currency_checker/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocLogger();

  runApp(const App());
}
