import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  EditAccountCubit() : super(EditAccountInitial(null));

  final UserRepository userRepository = UserRepository();
  File? defaultFile;

  Future<void> updateImage(File file) async {
    defaultFile = file;
    emit(EditAccountInitial(file));
  }

  Future<void> updateUser(File? file, String name, String albumName) async {
    try {
      emit(EditAccountStateShowPopUpLoading());
      await userRepository.updateAvatar(file, name, albumName);
      prefs!.setString(Constant.fullName, name);
      prefs!.setString(Constant.albumName, albumName);
      emit(EditAccountStateDismissPopUpLoading());
      emit(EditAccountStateSuccess());
    } on Exception catch (e) {
      emit(EditAccountStateDismissPopUpLoading());
      emit(EditAccountStateFail(e.toString()));
    }
  }
}
