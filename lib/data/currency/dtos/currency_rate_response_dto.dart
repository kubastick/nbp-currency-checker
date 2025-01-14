import 'package:json_annotation/json_annotation.dart';
import 'package:nbp_currency_checker/data/currency/dtos/currency_rate_dto.dart';

part 'currency_rate_response_dto.g.dart';

@JsonSerializable()
class CurrencyRateResponseDto {
  const CurrencyRateResponseDto({
    required this.table,
    required this.currency,
    required this.code,
    required this.rates,
  });

  factory CurrencyRateResponseDto.fromJson(Map<String, dynamic> json) => _$CurrencyRateResponseDtoFromJson(json);

  final String table;
  final String currency;
  final String code;
  final List<CurrencyRateDto> rates;

  Map<String, dynamic> toJson() => _$CurrencyRateResponseDtoToJson(this);
}
