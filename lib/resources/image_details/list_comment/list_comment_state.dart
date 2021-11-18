part of 'list_comment_cubit.dart';

@immutable
abstract class ListCommentState {}

class ListCommentInitial extends ListCommentState {
  ListCommentInitial(this.listComment);

  final List<Comment> listComment;
}

class ListCommentStateLoading extends ListCommentState{}

class ListCommentStateFail extends ListCommentState{
  ListCommentStateFail(this.message);

  final String message;
}

class ListCommentStateCallBack extends ListCommentState{
  ListCommentStateCallBack(this.totalComment);

  final int totalComment;
}