import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState.loading());

  var _date = DateTime.now();

  void initialize() {
    _emitIdle();
  }

  void setDate(DateTime date) {
    _date = date;
    _emitIdle();
  }

  void _emitIdle() {
    emit(HomePageState.idle(currencyDate: _date));
  }
}
