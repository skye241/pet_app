import 'package:bloc/bloc.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:meta/meta.dart';

part 'register_pet_state.dart';

class RegisterPetCubit extends Cubit<RegisterPetState> {
  RegisterPetCubit() : super(RegisterPetInitial(Gender.male, PetType()));

  Future<void> update(String gender, PetType petType) async {
    emit(RegisterPetInitial(gender, petType));
  }
}
