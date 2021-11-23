import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:family_pet/repository/share_repository.dart';
import 'package:meta/meta.dart';

part 'invite_relatives_state.dart';

class InviteRelativesCubit extends Cubit<InviteRelativesState> {
  InviteRelativesCubit() : super(InviteRelativesInitial());

  final MediaRepository mediaRepository = MediaRepository();
  final ShareRepository shareRepository = ShareRepository();
  String permission = PermissionPickMedia.family;
  Media media = Media();
  List<Media> listMediaDefault = <Media>[];
  String urlDefault = '';

  Future<void> sortAlbum(String permission) async {
    final List<Media> mediaByPer = listMediaDefault
        .where((Media media) => media.share! == permission)
        .toList();
    if (mediaByPer.isNotEmpty) {
      mediaByPer.sort((Media a, Media b) =>
          DateTime.parse(a.createdAt!).compareTo(DateTime.parse(b.createdAt!)));
      media = mediaByPer.first;
    urlDefault = createLink();
      emit(InviteRelativesLoaded(mediaByPer.first, permission, urlDefault));
      await saveLink(urlDefault );
    } else {
      media = Media();
      emit(InviteRelativesLoaded(Media(), permission, ''));
    }
  }

  Future<void> getAlbumByType() async {
    try {
      final List<Media> listMedia =
          await mediaRepository.getAlbum(PermissionPickMedia.mine) ?? <Media>[];
      listMediaDefault.addAll(listMedia);
      if (listMedia.isNotEmpty) {
        sortAlbum(PermissionPickMedia.family);
      } else {
        media = Media();
        emit(InviteRelativesLoaded(Media(), permission, ''));
      }
      // listMedia.indexWhere((Media media) => DateTime.parse(media.createdAt).);
    } on APIException catch (e) {
      emit(InviteRelativesStateFailed());
    }
  }

  String createLink() {
    return Url.baseURLShare +
        RoutesName.invitationPage +
        '/${prefs!.getInt(Constant.userId)}/$permission/${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> saveLink(String url) async {
    try {
      emit(InviteRelativesStateShowPopUpLoading());
      await shareRepository.saveLink(url, media.id!);
      emit(InviteRelativesStateDismissPopUpLoading());
    } on APIException catch (e) {
      emit(InviteRelativesStateDismissPopUpLoading());
      emit(InviteRelativesStateShowMessage(e.message()));
    }
  }
}
