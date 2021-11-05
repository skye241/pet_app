import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/genaral/constant/url.dart';
import 'package:family_pet/model/entity.dart';

class UserRepository {
  Future<void> registerUserFast(
      String fullName, String albumName, String deviceKey) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.fullName] = fullName;
    body[Constant.albumName] = albumName;
    body[Constant.deviceKey] = deviceKey;
    final APIResponse response =
        await callPOST(url: Url.registerFast, body: body);
    if (response.isOK ?? false) {
      return;
    } else
      print(response.message);
  }
}
