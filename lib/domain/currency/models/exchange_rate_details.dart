import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nbp_currency_checker/data/currency/dtos/currency_rate_response_dto.dart';

part 'exchange_rate_details.freezed.dart';

@freezed
class ExchangeRateDetails with _$ExchangeRateDetails {
  const factory ExchangeRateDetails({
    required DateTime date,
    required Decimal rate,
  }) = _ExchangeRateDetails;

  factory ExchangeRateDetails.fromDto(CurrencyRateResponseDto dto) {
    final firstRate = dto.rates.firstOrNull;
    if (firstRate == null) {
      throw Exception('Invalid dto data: rates are null');
    } else {
      return ExchangeRateDetails(
        date: firstRate.effectiveDate,
        rate: Decimal.parse(firstRate.mid.toString()),
      );
    }
  }
}
