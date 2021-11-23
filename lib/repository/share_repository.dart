import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';

class ShareRepository {
  final NetworkService networkService = NetworkService();

  Future<void> saveLink(String link, int mediaId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.link] = link;
    body[Constant.userId] = prefs!.getInt(Constant.userId);
    body[Constant.mediaId] = mediaId;
    final APIResponse response =
        await networkService.callPOST(url: Url.saveShareLink, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }
  Future<void> checkLink(String link, int mediaId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.link] = link;
    body[Constant.userId] = prefs!.getInt(Constant.userId);
    body[Constant.mediaId] = mediaId;
    final APIResponse response =
        await networkService.callPOST(url: Url.saveShareLink, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }
}
