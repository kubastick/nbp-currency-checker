import 'package:bloc_test/bloc_test.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nbp_currency_checker/data/currency/exceptions/missing_rates_exception.dart';
import 'package:nbp_currency_checker/domain/currency/currency_repository.dart';
import 'package:nbp_currency_checker/domain/currency/models/exchange_rate_details.dart';
import 'package:nbp_currency_checker/presentation/pages/home/widgets/exchange_rate_card/exchange_rate_card_cubit.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

class MockDate extends Mock implements DateTime {}

void main() {
  const hardcodedCurrencyCode = 'USD';

  late CurrencyRepository currencyRepository;

  late ExchangeRateCardCubit cubit;

  setUp(() {
    registerFallbackValue(Duration.zero);

    currencyRepository = MockCurrencyRepository();

    cubit = ExchangeRateCardCubit(currencyRepository);
  });

  final testDate = DateTime(0);
  blocTest<ExchangeRateCardCubit, ExchangeRateCardState>(
    'fetches currency rates',
    setUp: () {
      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).thenAnswer(
        (_) => Future.value(
          ExchangeRateDetails(
            date: DateTime(0),
            rate: Decimal.fromInt(1),
          ),
        ),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.initialize(testDate),
    expect: () => [
      ExchangeRateCardState.idle(
        exchangeRateDetails: ExchangeRateDetails(
          date: DateTime(0),
          rate: Decimal.fromInt(1),
        ),
        previousDayDifference: Decimal.fromInt(0),
      ),
    ],
    verify: (cubit) {
      verify(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).called(2);
    },
  );

  blocTest<ExchangeRateCardCubit, ExchangeRateCardState>(
    'handles missing rate exception',
    setUp: () {
      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).thenAnswer((_) => throw MissingRatesException());
    },
    build: () => cubit,
    act: (cubit) => cubit.initialize(testDate),
    expect: () => [
      const ExchangeRateCardState.missingRates(),
    ],
    verify: (cubit) {
      verify(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).called(1);
    },
  );

  final testGenericException = Exception('Test exception');
  blocTest<ExchangeRateCardCubit, ExchangeRateCardState>(
    'handles generic exceptions',
    setUp: () {
      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).thenAnswer((_) => throw testGenericException);
    },
    build: () => cubit,
    act: (cubit) => cubit.initialize(testDate),
    expect: () => [
      ExchangeRateCardState.error(testGenericException),
    ],
    verify: (cubit) {
      verify(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).called(1);
    },
  );

  final testProvidedRateDate = MockDate();
  final testExchangeRateDate = MockDate();
  final testPreviousRateDate = MockDate();
  blocTest<ExchangeRateCardCubit, ExchangeRateCardState>(
    'correctly calculates exchange rate difference',
    setUp: () {
      when(() => testProvidedRateDate.subtract(any())).thenAnswer(
        (_) => testExchangeRateDate,
      );
      when(() => testExchangeRateDate.subtract(any())).thenAnswer(
        (_) => testPreviousRateDate,
      );

      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: testExchangeRateDate,
        ),
      ).thenAnswer(
        (_) => Future.value(
          ExchangeRateDetails(
            date: DateTime(0),
            rate: Decimal.parse('1.3'),
          ),
        ),
      );

      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: testPreviousRateDate,
        ),
      ).thenAnswer(
        (i) => Future.value(
          ExchangeRateDetails(
            date: DateTime(0),
            rate: Decimal.parse('1.1'),
          ),
        ),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.initialize(testProvidedRateDate),
    expect: () => [
      ExchangeRateCardState.idle(
        exchangeRateDetails: ExchangeRateDetails(
          date: DateTime(0),
          rate: Decimal.parse('1.3'),
        ),
        previousDayDifference: Decimal.parse('0.2'),
      ),
    ],
    verify: (cubit) {
      verify(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).called(2);
    },
  );

  final testPreviousPreviousRateDate = MockDate();

  blocTest<ExchangeRateCardCubit, ExchangeRateCardState>(
    'Handles case when seek limit is reached',
    setUp: () {
      when(() => testProvidedRateDate.subtract(any())).thenAnswer(
        (_) => testExchangeRateDate,
      );
      when(() => testExchangeRateDate.subtract(any())).thenAnswer(
        (_) => testPreviousRateDate,
      );

      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: testExchangeRateDate,
        ),
      ).thenAnswer(
        (_) => Future.value(
          ExchangeRateDetails(
            date: DateTime(0),
            rate: Decimal.parse('1.3'),
          ),
        ),
      );

      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: testPreviousRateDate,
        ),
      ).thenAnswer((i) => throw MissingRatesException());

      when(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: testPreviousPreviousRateDate,
        ),
      ).thenAnswer(
        (i) => throw MissingRatesException(),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.initialize(testProvidedRateDate),
    expect: () => [
      ExchangeRateCardState.idle(
        exchangeRateDetails: ExchangeRateDetails(
          date: DateTime(0),
          rate: Decimal.parse('1.3'),
        ),
      ),
    ],
    verify: (cubit) {
      verify(
        () => currencyRepository.getNBPExchangeRate(
          currencyCode: hardcodedCurrencyCode,
          dateFor: any(named: 'dateFor'),
        ),
      ).called(11);
    },
  );
}
