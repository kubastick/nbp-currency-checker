part of 'exchange_rate_card_cubit.dart';

@freezed
class ExchangeRateCardState with _$ExchangeRateCardState {
  const factory ExchangeRateCardState.loading() = _ExchangeRateCardStateLoading;

  const factory ExchangeRateCardState.idle({
    required ExchangeRateDetails exchangeRateDetails,
    Decimal? previousDayDifference,
  }) = _ExchangeRateCardStateIdle;

  const factory ExchangeRateCardState.missingRates() = _ExchangeRateCardMissingRates;

  const factory ExchangeRateCardState.error([Object? error]) = _ExchangeRateCardStateError;
}
