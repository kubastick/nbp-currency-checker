part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.loading() = _HomePageStateLoading;

  const factory HomePageState.idle({
    required DateTime currencyDate,
  }) = _HomePageStateIdle;
}
