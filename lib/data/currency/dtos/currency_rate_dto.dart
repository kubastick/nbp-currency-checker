import 'package:json_annotation/json_annotation.dart';

part 'currency_rate_dto.g.dart';

@JsonSerializable()
class CurrencyRateDto {
  const CurrencyRateDto({
    required this.no,
    required this.effectiveDate,
    required this.mid,
  });

  factory CurrencyRateDto.fromJson(Map<String, dynamic> json) => _$CurrencyRateDtoFromJson(json);

  final String no;
  final DateTime effectiveDate;
  final double mid;

  Map<String, dynamic> toJson() => _$CurrencyRateDtoToJson(this);
}
