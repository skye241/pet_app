import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/relationship_repository.dart';
import 'package:family_pet/repository/share_repository.dart';
import 'package:meta/meta.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitial());

  final ShareRepository shareRepository = ShareRepository();
  final RelationshipRepository relationshipRepository =
      RelationshipRepository();
  Media defaultMedia = Media();

  Future<void> initEvent(String url) async {
    try {
      final Media media =
          await shareRepository.checkLink(Url.baseURLShare + url);
      defaultMedia = media;
      emit(InvitationStateLoaded(media));
    } on APIException catch (e) {
      emit(InvitationStateFail());
    }
  }

  Future<void> setRelationship(
      String url, int userId, String relationType) async {
    try {
      emit(InvitationStateShowPopUp());
      await relationshipRepository.setRelationship(
          userId, relationType, Url.baseURLShare + url);
      emit(InvitationStateDismissPopUp());
      emit(InvitationStateSuccessSetRela());
    } on APIException catch (e) {
      emit(InvitationStateDismissPopUp());
      if (e.apiResponse.code == 400) {
        emit(InvitationStateFailSetRela());
      } else
        emit(InvitationStateFail());
    }
  }
}
