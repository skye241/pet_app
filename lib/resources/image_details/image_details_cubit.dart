import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'image_details_state.dart';

class ImageDetailsCubit extends Cubit<ImageDetailsState> {
  ImageDetailsCubit() : super(ImageDetailsInitial(Media(), PermissionPickMedia.family));

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> updateMedia(Media media) async {
    print(media.share! + 'hello');
    emit(ImageDetailsInitial(media, media.share!));
  }

  Future<void> updatePermission(Media media, String permission) async {
    print(permission);
    emit(ImageDetailsInitial(media, permission));
  }

  Future<void> likeMedia(Media media) async {
    try {
      emit(ImageDetailsInitial(media.copyWith(isLiked: !media.isLiked!), media.share!));
      if (media.isLiked!) {
        await mediaRepository.unlike(media.id!);
      } else {
        await mediaRepository.like(media.id!);
      }
    } on APIException {
      emit(ImageDetailsInitial(media, media.share!));
    }
  }

  Future<void> saveImage(Media media) async {
    try {
      // final Response response =
      //     await get(Uri.parse(Url.baseURLImage + media.file!));
      // final Directory documentDirectory =
      //     await getApplicationDocumentsDirectory();
      // final File file = File(documentDirectory.path + media.mediaName!);
      // file.writeAsBytesSync(response.bodyBytes);
      // print('success');
      GallerySaver.saveImage(Url.baseURLImage + media.file!);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteMedia(Media media) async {
    try {
      emit(ImageDetailsStateShowPopUpLoading());
      await mediaRepository.deleteMedia(media.id!);
      emit(ImageDetailsStateDismissPopUpLoading());
      emit(ImageDetailsStateSuccess());
    } on APIException catch (e) {
      emit(ImageDetailsStateDismissPopUpLoading());
      emit(ImageDetailsStateFail(e.message()));
    }
  }

  Future<void> changePermission(Media media, String permission) async {
    try {
      emit(ImageDetailsStateShowPopUpLoading());
      await mediaRepository.changePermissionMedia(media.id!, permission);
      print(permission);
      emit(ImageDetailsInitial(media.copyWith(share: permission), permission));
      emit(ImageDetailsStateDismissPopUpLoading());
      emit(ImageDetailsStateFail('Cập nhật thành công'));
    } on APIException catch (e) {
      emit(ImageDetailsStateDismissPopUpLoading());
      emit(ImageDetailsStateFail(e.message()));
    }
  }
}
