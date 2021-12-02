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
    final APIResponse response = await networkService.callPOST(
        url: Url.registerFast,
        body: body,
        header: <String, String>{Constant.cookie: ''});
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
    await networkService.callPUT(url: Url.login, body: body);
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

  Future<void> updateUser(
      {String? email, String? password, String? deviceId}) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.albumName] = '';
    if (email != null) {
      body[Constant.email] = email;
    }
    if (password != null) {
      body[Constant.password] = password;
    }
    if (deviceId != null) {
      body[Constant.deviceId] = deviceId;
    }
    body[Constant.userId] = prefs?.getInt(Constant.userId);

    final APIResponse response =
    await networkService.callPUT(url: Url.updateUser, body: body);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> createUserFcmToken(String deviceId, String registrationId,
      String type, User user) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.deviceId] = deviceId;
    body[Constant.registrationId] = registrationId;
    body[Constant.type] = type;
    body[Constant.name] = prefs!.getString(Constant.fullName);
    // body[Constant.user] =  user.toMap();

    final APIResponse response =
    await networkService.callPOST(url: Url.createFcm,
        body: body,
        header: <String, String>{Constant.cookie: ''});

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> getNewToken() async {
    // body[Constant.user] =  user.toMap();

    final APIResponse response = await networkService.callGET(Url.checkToken);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> updateUserFcmToken(String deviceId, String registrationId,
      String type) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.deviceId] = deviceId;
    body[Constant.registrationId] = registrationId;
    body[Constant.type] = type;
    body[Constant.userId] = prefs?.getInt(Constant.userId);
    body[Constant.name] = prefs!.getString(Constant.fullName);

    final APIResponse response = await networkService.callPUT(
        url: Url.updateFcm + registrationId + '/',
        body: body,
        header: <String, String>{Constant.cookie: ''});

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
          response.data[Constant.result] as Map<String, dynamic>);

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
    await networkService.callPUT(url: Url.sendEmailActive, body: body);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }
}
