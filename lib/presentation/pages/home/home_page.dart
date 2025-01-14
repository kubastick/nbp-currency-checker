import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbp_currency_checker/core/di/injectable.dart';
import 'package:nbp_currency_checker/l10n/l10n_extension.dart';
import 'package:nbp_currency_checker/presentation/pages/home/home_page_cubit.dart';
import 'package:nbp_currency_checker/presentation/pages/home/widgets/exchange_rate_card/exchange_rate_card.dart';
import 'package:nbp_currency_checker/presentation/widgets/date_picker_button.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home_nbpCurrencyChecker),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<HomePageCubit>()..initialize(),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(context.l10n.home_currencyDate),
                    const SizedBox(height: 4),
                    DateTextField(
                      date: state.maybeMap(
                        orElse: DateTime.now,
                        idle: (state) => state.currencyDate,
                      ),
                      onDateSelected: context.read<HomePageCubit>().setDate,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(context.l10n.home_details),
                state.maybeMap(
                  idle: (state) => ExchangeRateCard(date: state.currencyDate),
                  orElse: SizedBox.shrink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
