import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';

class CommentRepository {
  final NetworkService networkService = NetworkService();

  Future<List<Comment>?> getListComment(int mediaId) async {
    final APIResponse response = await networkService
        .callGET(Url.getListComment + '?${Constant.mediaId}=$mediaId');
    final List<Comment> listComment = <Comment>[];

    if (response.isOK!) {
      if (response.data != null) {
        for (final dynamic item
            in response.data![Constant.result] as List<dynamic>) {
          listComment.add(Comment.fromMap(item as Map<String, dynamic>));
        }
        return listComment;
      }
    } else
      throw APIException(response);
  }

  Future<int> postComment(int mediaId, int userId, String content) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.mediaId] = mediaId;
    body[Constant.userId] = userId;
    body[Constant.content] = content;
    body[Constant.commenterId] = prefs!.getInt(Constant.userId);
    final APIResponse response =
        await networkService.callPOST(url: Url.postComment, body: body);

    if (response.isOK!) {
      return getInt(Constant.commentId, response.data as Map<String, dynamic>);
    } else
      throw APIException(response);
  }

  Future<void> delComment(int commentId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.commentId] = commentId;
    body[Constant.commenterId] = prefs!.getInt(Constant.userId);
    final APIResponse response =
        await networkService.callPOST(url: Url.deleteComment, body: body);

    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }
}
