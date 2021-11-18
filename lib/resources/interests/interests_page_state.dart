part of 'interests_page_cubit.dart';

@immutable
abstract class InterestsPageState {}

class InterestsPageInitial extends InterestsPageState {}

class InterestsPageStateSuccess extends InterestsPageState{
  InterestsPageStateSuccess(this.listImage);

  final List<Media> listImage;
}

class InterestsPageStateLoading extends InterestsPageState{}

class InterestsPageStateFail extends InterestsPageState{
  InterestsPageStateFail(this.message);

  final String message;
}