import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_slide_state.dart';

class MonthPickerCubit extends Cubit<MonthPickerState> {
  MonthPickerCubit()
      : super(MonthPickerInitial(
            DateTime(DateTime.now().year, DateTime.now().month, 1),
            // ignore: prefer_const_literals_to_create_immutables
            <DateTime>[]));

  Future<void> initEvent(int? numberOfMonth, DateTime? initMonth) async {
    final List<DateTime> listDateTime = List<DateTime>.generate(
        numberOfMonth ?? 6,
        (int index) =>
            DateTime(DateTime.now().year, DateTime.now().month - index, 1));
    emit(MonthPickerInitial(
        initMonth ?? DateTime(DateTime.now().year, DateTime.now().month, 1),
        listDateTime));
  }

  Future<void> chooseMonth(
      DateTime dateTime, List<DateTime> listDateTime) async {
    emit(MonthPickerInitial(dateTime, listDateTime));
  }
}
