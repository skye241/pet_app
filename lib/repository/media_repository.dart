import 'dart:convert';
import 'dart:io';

import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:http/http.dart';

class MediaRepository {
  final NetworkService networkService = NetworkService();

  Future<int> createMedia(File file, String type, String share) async {
    final Map<String, String> body = <String, String>{};

    body[Constant.userId] = prefs!.getInt(Constant.userId).toString();
    body[Constant.mediaType] = type;
    body[Constant.tShare] = share;

    final StreamedResponse response = await networkService.uploadImage(file, body);
    int imageId;
    final String rep = await response.stream.bytesToString();

    final Map<String, dynamic> json = jsonDecode(rep) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      imageId = getInt(Constant.mediaId, json);
    } else {
      throw Exception(rep);
    }

    print('CHECKING OUTPUT ===========$imageId');
    return imageId;
  }

  Future<List<Media>>? getAlbum(String share) async {
    final APIResponse response = await networkService.callGET(Url.getAlbum +
        '?${Constant.userId}=${prefs?.getInt(Constant.userId)}&${Constant.typeAlbum}=$share');
    final List<Media> listMedia = <Media>[];
    if (response.isOK ?? false) {
      if (response.data != null) {
        if (share == PermissionPickMedia.mine) {
          for (final dynamic item
              in response.data![Constant.result] as List<dynamic>) {
            listMedia.add(Media.fromMap(item as Map<String, dynamic>));
          }
        } else {
          for (final dynamic listItem
              in response.data![Constant.result] as List<dynamic>) {
            for (final dynamic item in listItem as List<dynamic>) {
              listMedia.add(Media.fromMap(item as Map<String, dynamic>));
            }
          }
        }
      }
      return listMedia;
    } else
      throw APIException(response);
  }

  Future<List<Media>>? getFavouriteMedia() async {
    final APIResponse response = await networkService.callGET(
        Url.getFavouriteMedia +
            '?${Constant.userId}=${prefs?.getInt(Constant.userId)}');
    final List<Media> listMedia = <Media>[];
    if (response.isOK ?? false) {
      if (response.data != null) {
        for (final dynamic item
            in response.data![Constant.result] as List<dynamic>) {
          listMedia.add(Media.fromMap(item as Map<String, dynamic>)
              .copyWith(isLiked: true));
        }
      }
      return listMedia;
    } else
      throw APIException(response);
  }

  Future<void> deleteMedia(int mediaId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.mediaId] = mediaId;
    final APIResponse response =
        await networkService.callPOST(url: Url.deleteMedia, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> changePermissionMedia(int mediaId, String permission) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.mediaId] = mediaId;
    body[Constant.tShare] = permission;
    body[Constant.userId] = prefs!.getInt(Constant.userId);
    final APIResponse response =
        await networkService.callPUT(url: Url.changePermission, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> like(int mediaId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.mediaId] = mediaId;
    body[Constant.userId] = prefs!.getInt(Constant.userId);

    final APIResponse response =
        await networkService.callPOST(url: Url.like, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }

  Future<void> unlike(int mediaId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.mediaId] = mediaId;
    body[Constant.userId] = prefs!.getInt(Constant.userId);

    final APIResponse response =
        await networkService.callPOST(url: Url.unlike, body: body);
    if (response.isOK!) {
      return;
    } else
      throw APIException(response);
  }
}
