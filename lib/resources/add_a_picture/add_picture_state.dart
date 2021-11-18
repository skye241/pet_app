part of 'add_picture_cubit.dart';

@immutable
abstract class AddPictureState {}

class AddPictureInitial extends AddPictureState {
  AddPictureInitial(this.image, this.permission);

  final File? image;
  final String permission;
}

class AddPictureStateShowLoading extends AddPictureState {}

class AddPictureStateDismissLoading extends AddPictureState {}

class AddPictureStateSuccess extends AddPictureState {}

class AddPictureStateFail extends AddPictureState {
  AddPictureStateFail(this.message);

  final String message;
}
