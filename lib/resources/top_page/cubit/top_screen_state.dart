part of 'top_screen_cubit.dart';

@immutable
abstract class TopScreenState {}

class TopScreenInitial extends TopScreenState {}

class TopScreenStateShowLoading extends TopScreenState {}

class TopScreenStateDismissLoading extends TopScreenState {}

class TopScreenStateFail extends TopScreenState {
  TopScreenStateFail(this.message);

  final String message;
}

class TopScreenStateSuccess extends TopScreenState {}
