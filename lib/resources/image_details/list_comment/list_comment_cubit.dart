import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/comment_repository.dart';
import 'package:meta/meta.dart';

part 'list_comment_state.dart';

class ListCommentCubit extends Cubit<ListCommentState> {
  ListCommentCubit() : super(ListCommentInitial(const <Comment>[]));

  final CommentRepository commentRepository = CommentRepository();

  Future<void> initEvent(Media media) async {
    try {
      emit(ListCommentStateLoading());
      final List<Comment> listComment = <Comment>[];
      listComment.addAll(
          await commentRepository.getListComment(media.id!) ?? <Comment>[]);
      print(listComment);
      emit(ListCommentInitial(listComment));
    } on APIException catch (e) {
      emit(ListCommentStateFail(e.message()));
    }
  }

  Future<void> postComment(
      Media media, String content, List<Comment> listComment) async {
    try {
      final int commentId = await commentRepository.postComment(
          media.id!, media.user!.id!, content);
      listComment.insert(
          0,
          Comment(
              media: media,
              user: User(id: prefs!.getInt(Constant.userId), email: ''),
              content: content,
              id: commentId,
              userName: 'Vân',
              avatar: ''));
      emit(ListCommentStateCallBack(listComment.length));
      emit(ListCommentInitial(listComment));
    } on APIException catch (e) {
      emit(ListCommentInitial(listComment));
    }
  }

  Future<void> deleteComment(Comment comment, List<Comment> listComment) async {
    try {
      await commentRepository.delComment(comment.id!);
      listComment.removeWhere((Comment e) => e.id == comment.id);
      emit(ListCommentStateCallBack(listComment.length));
      emit(ListCommentInitial(listComment));
    } on APIException {
      emit(ListCommentInitial(listComment));
    }
  }
}
