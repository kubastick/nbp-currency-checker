import 'package:flutter/cupertino.dart';
import 'package:nbp_currency_checker/l10n/localizations/app_localizations.dart';

extension L10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
