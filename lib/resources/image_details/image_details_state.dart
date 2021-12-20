part of 'image_details_cubit.dart';

@immutable
abstract class ImageDetailsState {}

class ImageDetailsInitial extends ImageDetailsState {
  ImageDetailsInitial(this.media, this.permission);

  final Media media;
  final String permission;
}

class ImageDetailsStateShowPopUpLoading extends ImageDetailsState {}

class ImageDetailsStateDismissPopUpLoading extends ImageDetailsState {}

class ImageDetailsStateShowMessage extends ImageDetailsState {
  ImageDetailsStateShowMessage(this.message);

  final String message;
}

class ImageDetailsStateSuccess extends ImageDetailsState {
  ImageDetailsStateSuccess(this.afterPop, this.message);
  final String message;

  final VoidCallback afterPop;
}
