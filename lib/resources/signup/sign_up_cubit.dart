import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial(true, true));

  final UserRepository _userRepository = UserRepository();
  bool enable = true;

  Future<void> showPassword(bool showPass) async {
    emit(SignUpInitial(!showPass, enable));
  }

  Future<void> updateEnable(bool enable) async {
    emit(SignUpInitial(true, enable));
  }

  Future<void> register(String email, String password) async {
    try {
      emit(SignUpShowPopUpLoading());
      // final UserInfo userInfo = UserInfo(
      //     deviceKey: prefs!.getString(Constant.deviceKey),
      //     fullName: prefs!.getString(Constant.fullName),
      //     user: User(
      //         id: prefs!.getInt(Constant.userId),
      //         email: email,
      //         password: password));
      await _userRepository.updateUser(email: email, password: password);
      await _userRepository.sendEmail(email);
      emit(SignUpDismissPopUpLoading());
      emit(SignUpSuccess());
    } on APIException catch (e) {
      emit(SignUpDismissPopUpLoading());
      emit(SignUpFail(e.message()));
    }
  }

  Future<void> resendEmail(String email) async {
    try {
      emit(SignUpShowPopUpLoading());
      // final UserInfo userInfo = UserInfo(
      //     deviceKey: prefs!.getString(Constant.deviceKey),
      //     fullName: prefs!.getString(Constant.fullName),
      //     user: User(
      //         id: prefs!.getInt(Constant.userId),
      //         email: email,
      //         password: password));
      await _userRepository.sendEmail(email);
      emit(SignUpDismissPopUpLoading());
      emit(SignUpSuccess());
    } on APIException catch (e) {
      emit(SignUpDismissPopUpLoading());
      emit(SignUpFail(e.message()));
    }
  }
}
