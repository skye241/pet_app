class Url {
  static const String baseURL = 'http://34.146.194.201:8080/famipet/';
  // static const String baseURL = 'https://famipet-dot-sateraito-dronesearch-dev.an.r.appspot.com/famipet/';

  static const String registerFast = baseURL + 'device/register/';
  static const String getListPetType = baseURL + 'pettype/';
  static const String createPet = baseURL + 'pet/create/';
  static const String checkDeviceId = baseURL + 'device/get-by-device/';
  static const String updateUser = baseURL + 'userinfo/update/';
  static const String uploadMedia = baseURL + 'media/upload-media/';
  static const String getAlbum = baseURL + 'media/album_media';
  static const String deleteMedia = baseURL + 'media/del_media/';
  static const String getListPet = baseURL + 'pet/get-by-user/';
}
