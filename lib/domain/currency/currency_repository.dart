import 'package:nbp_currency_checker/domain/currency/models/exchange_rate_details.dart';

abstract interface class CurrencyRepository {
  Future<ExchangeRateDetails> getNBPExchangeRate({
    required String currencyCode,
    required DateTime dateFor,
  });
}
