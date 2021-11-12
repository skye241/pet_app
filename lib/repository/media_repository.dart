import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/genaral/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';

class MediaRepository {
  final NetworkService networkService = NetworkService();

  Future<void> createMedia(String file, String type) async {
    final Map<String, dynamic> body = <String, dynamic>{};

    body[Constant.userId] = prefs!.getInt(Constant.userId);
    body[Constant.file] =
        'https://photo2.tinhte.vn/data/attachment-files/2021/03/5393140_file-20181102-83644-b06itk.jpg';
    body[Constant.mediaType] = type;

    final APIResponse response =
        await networkService.callPOST(url: Url.uploadMedia, body: body);

    if (response.isOK ?? false) {
      return;
    } else
      throw APIException(response);
  }

  Future<List<Media>>? getAlbum(String share) async {
    final APIResponse response = await networkService.callGET(Url.getAlbum +
        '?${Constant.userId}=${prefs?.getInt(Constant.userId)}&${Constant.typeAlbum}=$share');
    final List<Media> listMedia = <Media>[];
    if (response.isOK ?? false) {
      for (final dynamic item in response.data?[Constant.results]) {
        listMedia.add(Media.fromMap(item as Map<String, dynamic>));
      }
      return listMedia;
    } else
      throw APIException(response);
  }
}
