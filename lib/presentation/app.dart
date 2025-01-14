import 'package:flutter/material.dart';
import 'package:nbp_currency_checker/l10n/localizations/app_localizations.dart';
import 'package:nbp_currency_checker/presentation/routing/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
