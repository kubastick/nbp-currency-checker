import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbp_currency_checker/core/di/injectable.dart';
import 'package:nbp_currency_checker/l10n/l10n_extension.dart';
import 'package:nbp_currency_checker/presentation/pages/home/widgets/exchange_rate_card/exchange_rate_card_cubit.dart';
import 'package:nbp_currency_checker/presentation/pages/home/widgets/exchange_rate_card/widgets/currency_difference_indicator.dart';

class ExchangeRateCard extends StatelessWidget {
  const ExchangeRateCard({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(date),
      create: (context) => getIt<ExchangeRateCardCubit>()..initialize(date),
      child: BlocBuilder<ExchangeRateCardCubit, ExchangeRateCardState>(
        builder: (context, state) => state.map(
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          idle: (state) {
            final previousDayDifference = state.previousDayDifference;

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (previousDayDifference != null) ...[
                      CurrencyDifferenceIndicator(difference: previousDayDifference),
                      const SizedBox(height: 40),
                    ],
                    Text(
                      context.l10n.exchangeRateCard_yesterdayNBPRate(state.exchangeRateDetails.date),
                    ),
                    Text(
                      state.exchangeRateDetails.rate.toString(),
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
          missingRates: (_) => Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.question_mark,
                      size: 40,
                    ),
                    const SizedBox(height: 24),
                    Text(context.l10n.exchangeRateCard_noExchangeRates),
                  ],
                ),
              ),
            ),
          ),
          error: (error) => Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.error_outline),
                    Text(context.l10n.exchangeRateCard_somethingWentWrong),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
