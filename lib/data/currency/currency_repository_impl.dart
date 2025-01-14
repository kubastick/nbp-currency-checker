import 'package:injectable/injectable.dart';
import 'package:nbp_currency_checker/data/currency/data_sources/nbp_data_source.dart';
import 'package:nbp_currency_checker/data/currency/dtos/currency_rate_response_dto.dart';
import 'package:nbp_currency_checker/data/currency/exceptions/missing_rates_exception.dart';
import 'package:nbp_currency_checker/domain/currency/currency_repository.dart';
import 'package:nbp_currency_checker/domain/currency/models/exchange_rate_details.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._nbpDataSource);

  final NBPDataSource _nbpDataSource;

  @override
  Future<ExchangeRateDetails> getNBPExchangeRate({
    required String currencyCode,
    required DateTime dateFor,
  }) async {
    final exchangeRateResponse = await _nbpDataSource.getExchangeRates(
      currencyCode,
      NBPDataSource.dateFormatter.format(dateFor),
    );

    if (exchangeRateResponse.statusCode == 404) {
      throw MissingRatesException();
    }

    final dto = CurrencyRateResponseDto.fromJson(
      exchangeRateResponse.bodyOrThrow,
    );

    return ExchangeRateDetails.fromDto(dto);
  }
}
