part of 'calendar_slide_cubit.dart';

@immutable
abstract class MonthPickerState {}

class MonthPickerInitial extends MonthPickerState {
  MonthPickerInitial(this.dateTime, this.listDateTime);

  final DateTime dateTime;
  final List<DateTime> listDateTime;

}
