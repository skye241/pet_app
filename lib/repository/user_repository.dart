import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/genaral/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';

import '../main.dart';

class UserRepository {
  final NetworkService networkService = NetworkService();

  Future<void> getByDevice() async {}

  Future<UserInfo?> registerUserFast(String fullName, String deviceKey) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.fullName] = fullName;
    body[Constant.location] = Location.vietnam;
    body[Constant.deviceKey] = deviceKey;
    final APIResponse response =
        await networkService.callPOST(url: Url.registerFast, body: body);
    if (response.isOK ?? false) {
      prefs!.setInt(Constant.userId, getInt(Constant.userId, response.data));
      prefs!.setString(Constant.fullName, getString(Constant.fullName, response.data));
      prefs!.setString(Constant.deviceKey, getString(Constant.deviceKey, response.data));
      prefs!.setString(Constant.location, getString(Constant.location, response.data));

      return UserInfo.fromMap(response.data);
    } else
      throw APIException(response);
  }

  Future<void> updateUser(UserInfo userInfo) async {
    final Map<String, dynamic> body = userInfo.toMap();
    body[Constant.albumName] = '';

    final APIResponse response = await networkService.callPUT(url: Url.updateUser, body: body);

    if (response.isOK?? false){
      return;
    } else
      throw APIException(response);
  }
}
