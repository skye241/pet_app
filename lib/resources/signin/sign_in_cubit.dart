import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial(true));
  final UserRepository _userRepository = UserRepository();
  bool isShow = true;

  Future<void> changeShowPass(bool showPass) async {
    isShow = showPass;
    emit(SignInInitial(showPass));
  }

  Future<void> login(String email, String password) async {
    try {
      emit(SignInShowPopUpLoading());
      await _userRepository.login(email, password);
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateSuccess());
    } on APIException catch (e) {
      emit(SignInShowDismissPopUpLoading());
      emit(SignInStateFail(e.message()));
    }
  }
}
