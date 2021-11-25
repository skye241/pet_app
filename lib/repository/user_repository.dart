import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';

import '../main.dart';

class UserRepository {
  final NetworkService networkService = NetworkService();

  Future<void> getByDevice() async {}

  Future<UserInfo?> registerUserFast(String fullName, String deviceKey) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.fullName] = fullName;
    body[Constant.location] = prefs!.getString(Constant.language) == 'ja'
        ? Location.japan
        : Location.vietnam;
    body[Constant.deviceKey] = deviceKey;
    final APIResponse response =
        await networkService.callPOST(url: Url.registerFast, body: body);
    if (response.isOK ?? false) {
      final UserInfo user =
          UserInfo.fromMap(response.data as Map<String, dynamic>);

      prefs!.setInt(Constant.userId,
          getInt(Constant.userId, response.data as Map<String, dynamic>));
      // prefs!.setString(Constant.email, user.user!.email!);
      prefs!.setString(Constant.fullName,
          getString(Constant.fullName, response.data as Map<String, dynamic>));
      // prefs!.setString(Constant.avatar, user.avatar!);
      prefs!.setString(Constant.location,
          getString(Constant.location, response.data as Map<String, dynamic>));
      prefs!.setString(Constant.deviceKey,
          getString(Constant.deviceKey, response.data as Map<String, dynamic>));
      return user;
    } else
      throw APIException(response);
  }

  Future<UserInfo?> login(String email, String password) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.email] = email;
    body[Constant.password] = password;
    final APIResponse response =
        await networkService.callPOST(url: Url.login, body: body);
    if (response.isOK ?? false) {
      // prefs!.setString(Constant.location,
      //     getString(Constant.location, response.data as Map<String, dynamic>));

      final UserInfo user =
          UserInfo.fromMap(response.data as Map<String, dynamic>);

      prefs!.setInt(Constant.userId, user.user!.id!);
      prefs!.setString(Constant.email, user.user!.email!);
      prefs!.setString(Constant.fullName, user.fullName!);
      prefs!.setString(Constant.avatar, user.avatar!);
      return user;
    } else
      throw APIException(response);
  }

  Future<void> updateUser(String email, String password) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.albumName] = '';
    body[Constant.email] = email;
    body[Constant.password] = password;
    body[Constant.userId] = prefs?.getInt(Constant.userId);

    final APIResponse response =
        await networkService.callPUT(url: Url.updateUser, body: body);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }

  Future<UserInfo> viewUserById() async {
    final APIResponse response = await networkService.callGET(
        Url.getUserInfoById +
            '?${Constant.id}=${prefs!.getInt(Constant.userId)}');

    if (response.isOK ?? false) {
      final UserInfo user = UserInfo.fromMap(
              response.data[Constant.userInfo] as Map<String, dynamic>)
          .copyWith(
              isActive: getBool(
                  Constant.isActive, response.data as Map<String, dynamic>));

      prefs!.setInt(Constant.userId, user.user!.id!);
      prefs!.setString(Constant.email, user.user!.email!);
      prefs!.setString(Constant.fullName, user.fullName!);
      prefs!.setString(Constant.avatar, user.avatar!);
      return user;
    } else
      throw APIException(response);
  }

  Future<void> sendEmail(String email) async {
    final Map<String, dynamic> body = <String, dynamic>{
      Constant.email: email,
      // Constant.userId: prefs!.getInt(Constant.userId)
    };
    final APIResponse response =
        await networkService.callPOST(url: Url.sendEmailActive, body: body);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }
}
