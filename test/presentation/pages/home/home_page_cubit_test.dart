import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nbp_currency_checker/presentation/pages/home/home_page_cubit.dart';

void main() {
  late HomePageCubit cubit;

  setUp(() {
    cubit = HomePageCubit();
  });

  final testDate = DateTime(0);
  blocTest<HomePageCubit, HomePageState>(
    'setting date works',
    build: () => cubit,
    act: (cubit) => cubit.setDate(testDate),
    expect: () => [
      HomePageState.idle(currencyDate: testDate),
    ],
  );
}
