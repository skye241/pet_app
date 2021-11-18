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

class ImageDetailsStateFail extends ImageDetailsState {
  ImageDetailsStateFail(this.message);

  final String message;
}
class ImageDetailsStateSuccess extends ImageDetailsState {
}

