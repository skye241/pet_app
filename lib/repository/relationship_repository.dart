import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';

class RelationshipRepository {
  final NetworkService networkService = NetworkService();

  Future<List<UserInfo>> getRelationship() async {
    final APIResponse response = await networkService.callGET(Url
            .getRelationship +
        '?${Constant.userId}=${prefs!.getInt(Constant.userId)}');
    if (response.isOK!) {
      final List<UserInfo> listUser = <UserInfo>[];
      for (final dynamic item
          in response.data[Constant.result] as List<dynamic>) {
        listUser.add(UserInfo.fromMap(item as Map<String, dynamic>));
      }
      return listUser;
    } else
      throw APIException(response);
  }

  Future<void> setRelationship(
      int userId, String relationType, String link) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.userId] = userId;
    body[Constant.relationType] = relationType;
    body[Constant.targetId] = prefs!.getInt(Constant.userId);
    body[Constant.link] = link;
    final APIResponse response =
        await networkService.callPUT(url: Url.setRelationship, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> deleteRelationship(
      int userId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.userId] = prefs!.getInt(Constant.userId);
    body[Constant.targetId] = userId;
    final APIResponse response =
        await networkService.callPOST(url: Url.removeRelationship, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }
}
