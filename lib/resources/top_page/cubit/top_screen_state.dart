part of 'top_screen_cubit.dart';

@immutable
abstract class TopScreenState {}

class TopScreenInitial extends TopScreenState {
  TopScreenInitial(this.index, this.images, this.permission);

  final int index;
  final Set<File> images;
  final String permission;
}

class TopScreenStateShowLoading extends TopScreenState {}

class TopScreenStateDismissLoading extends TopScreenState {}

class TopScreenStateFail extends TopScreenState {
  TopScreenStateFail(this.message);

  final String message;
}

class TopScreenStateSuccess extends TopScreenState {}


