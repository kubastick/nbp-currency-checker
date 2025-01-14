import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nbp_currency_checker/core/di/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
