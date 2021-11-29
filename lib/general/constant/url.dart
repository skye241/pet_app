class Url {
  static const String baseURL = 'http://34.146.194.201:8080/famipet/';
  static const String baseURLImage = 'http://34.146.194.201:8080/static/';
  static const String baseURLShare = 'customscheme://familypetcls.com';

  // static const String baseURL = 'https://famipet-dot-sateraito-dronesearch-dev.an.r.appspot.com/famipet/';
  ///USER & USERINFO
  static const String registerFast = baseURL + 'device/register/';
  static const String getListPetType = baseURL + 'pettype/';
  static const String createPet = baseURL + 'pet/create/';
  static const String checkDeviceId = baseURL + 'device/get-by-device/';
  static const String updateUser = baseURL + 'userinfo/update/';
  static const String getUserInfoById = baseURL + 'userinfo/get-by-id/';
  static const String sendEmailActive = baseURL + 'userinfo/send-mail-active/';
  static const String login = baseURL + 'userinfo/login/';
  static const String createFcm = baseURL + 'fcmdevices/';

  ///MEDIA
  static const String uploadMedia = baseURL + 'media/upload-media/';
  static const String getAlbum = baseURL + 'media/album-media';
  static const String deleteMedia = baseURL + 'media/del-media/';
  static const String getListPet = baseURL + 'pet/get-by-user/';
  static const String like = baseURL + 'media/like/';
  static const String unlike = baseURL + 'media/unlike/';
  static const String changePermission = baseURL + 'media/change-stt-media/';
  static const String getFavouriteMedia = baseURL + 'media/favorite-album/';

  ///COMMENT
  static const String getListComment = baseURL + 'comment/get-comment/';
  static const String postComment = baseURL + 'comment/input-comment/';
  static const String deleteComment = baseURL + 'comment/del-comment/';

  ///SHARE & RELATIVES
  static const String checkShareLink = baseURL + 'share/share-accept/';
  static const String saveShareLink = baseURL + 'share/sharing/';

  ///RELATIONSHIP
  static const String getRelationship =
      baseURL + 'relationship/get-relationship/';
  static const String setRelationship =
      baseURL + 'relationship/set-relationship/';
  static const String removeRelationship =
      baseURL + 'relationship/unrelationship/';
}
