import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:nbp_currency_checker/l10n/l10n_extension.dart';

class CurrencyDifferenceIndicator extends StatelessWidget {
  const CurrencyDifferenceIndicator({
    required this.difference,
    super.key,
  });

  final Decimal difference;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          switch (difference.toDouble()) {
            0 => Icons.play_arrow_rounded,
            > 0 => Icons.arrow_drop_up,
            < 0 => Icons.arrow_drop_down,
            double() => Icons.question_mark,
          },
          size: 70,
          color: switch (difference.toDouble()) {
            0 => Colors.yellow,
            > 0 => Colors.green,
            < 0 => Colors.red,
            double() => Colors.black,
          },
        ),
        Text(
          switch (difference.toDouble()) {
            0 => context.l10n.currencyDifference_exchangeRateRemainedUnchanged,
            > 0 => context.l10n.currencyDifference_exchangeRateIncreased,
            < 0 => context.l10n.currencyDifference_exchangeRateDecreased,
            double() => '',
          },
        ),
        Text(
          context.l10n.currencyDifference_difference(difference.toString()),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
