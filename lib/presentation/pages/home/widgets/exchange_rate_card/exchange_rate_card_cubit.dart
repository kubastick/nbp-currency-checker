import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nbp_currency_checker/data/currency/exceptions/missing_rates_exception.dart';
import 'package:nbp_currency_checker/domain/currency/currency_repository.dart';
import 'package:nbp_currency_checker/domain/currency/models/exchange_rate_details.dart';

part 'exchange_rate_card_cubit.freezed.dart';

part 'exchange_rate_card_state.dart';

@injectable
class ExchangeRateCardCubit extends Cubit<ExchangeRateCardState> {
  ExchangeRateCardCubit(this._currencyRepository) : super(const ExchangeRateCardState.loading());

  final CurrencyRepository _currencyRepository;

  static const _currency = 'USD';
  static const _previousDayExchangeRateSeekLimit = 10;

  Future<void> initialize(DateTime date) async {
    try {
      final dayBefore = date.subtract(const Duration(days: 1));

      final exchangeRateDetails = await _currencyRepository.getNBPExchangeRate(
        currencyCode: _currency,
        dateFor: dayBefore,
      );

      ExchangeRateDetails? exchangeRateDetailsFromDayBefore;
      try {
        exchangeRateDetailsFromDayBefore = await exchangeRateFromDayBefore(dayBefore);
      } on Exception catch (_) {}

      emit(
        ExchangeRateCardState.idle(
          exchangeRateDetails: exchangeRateDetails,
          previousDayDifference: switch (exchangeRateDetailsFromDayBefore) {
            final ExchangeRateDetails details => (exchangeRateDetails.rate - details.rate),
            null => null,
          },
        ),
      );
    } on MissingRatesException catch (_) {
      emit(const ExchangeRateCardState.missingRates());
    } on Exception catch (e) {
      emit(ExchangeRateCardState.error(e));
    }
  }

  Future<ExchangeRateDetails> exchangeRateFromDayBefore(DateTime currencyDate) async {
    for (var x = 0; x < _previousDayExchangeRateSeekLimit; x++) {
      try {
        final result = await _currencyRepository.getNBPExchangeRate(
          currencyCode: _currency,
          dateFor: currencyDate.subtract(Duration(days: x + 1)),
        );

        return result;
      } on MissingRatesException catch (_) {
        continue;
      }
    }

    throw Exception('Reached previous day exchange rate seek limit');
  }
}
