import 'package:bloc/bloc.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'register_fast_state.dart';

class RegisterFastCubit extends Cubit<RegisterFastState> {
  RegisterFastCubit() : super(RegisterFastInitial());

  final UserRepository userRepository = UserRepository();

  Future<void> registerUser (String fullName) async{

  }
}
