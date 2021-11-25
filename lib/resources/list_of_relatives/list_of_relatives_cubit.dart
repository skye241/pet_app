import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/relationship_repository.dart';
import 'package:meta/meta.dart';

part 'list_of_relatives_state.dart';

class ListOfRelativesCubit extends Cubit<ListOfRelativesState> {
  ListOfRelativesCubit()
      : super(ListOfRelativesInitial(<UserInfo>[], <UserInfo>[]));

  final RelationshipRepository relationshipRepository =
      RelationshipRepository();
  final List<UserInfo> defaultFamily = <UserInfo>[];
  final List<UserInfo> defaultFriend = <UserInfo>[];

  Future<void> initEvent(
      List<UserInfo> familyList, List<UserInfo> friendList) async {
    emit(ListOfRelativesInitial(familyList, friendList));
  }

  Future<void> deleteRelation(UserInfo userInfo) async {
    try {
      emit(ListOfRelativesStateShowLoading());
      await relationshipRepository.deleteRelationship(userInfo.user!.id!);

      if (userInfo.relationType == PermissionPickMedia.family) {
        defaultFamily
            .removeWhere((UserInfo user) => userInfo.user!.id == user.user!.id);
      } else
        defaultFriend
            .removeWhere((UserInfo user) => userInfo.user!.id == user.user!.id);
      emit(ListOfRelativesStateDismissLoading());
      emit(ListOfRelativesInitial(defaultFamily, defaultFamily));
    } on APIException catch (e) {
      emit(ListOfRelativesStateDismissLoading());
      emit(ListOfRelativesStateShowMessage(e.message()));
    }
  }
}
