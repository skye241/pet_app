part of 'pick_media_cubit.dart';

@immutable
abstract class PickMediaState {}

class PickMediaInitial extends PickMediaState {
  PickMediaInitial(this.listImage, this.permission);

  final List<File> listImage;
  final String permission;
}

class PickMediaStateShowPopUpLoading extends PickMediaState {}

class PickMediaStateDismissPopUpLoading extends PickMediaState {}

class PickMediaStateSuccess extends PickMediaState {}

class PickMediaStateFail extends PickMediaState {
  PickMediaStateFail(this.message);

  final String message;
}
