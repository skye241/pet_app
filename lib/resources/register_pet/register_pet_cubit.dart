import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/pet_repository.dart';
import 'package:meta/meta.dart';

part 'register_pet_state.dart';

class RegisterPetCubit extends Cubit<RegisterPetState> {
  RegisterPetCubit() : super(RegisterPetInitial(Gender.male, PetType()));

  final PetRepository petRepository = PetRepository();

  Future<void> update(String gender, PetType petType) async {
    emit(RegisterPetInitial(gender, petType));
  }

  Future<void> createPet(String name, String gender, PetType petType,
      String birthday) async {
    try {
      emit(RegisterPetStateShowPopUpLoading());
      final int petId =
      await petRepository.createPet(name, petType.id, gender, birthday);
      final Pet pet = Pet(
          id: petId,
          name: name,
          petType: petType,
          gender: gender,
          birthdate: birthday
      );
      emit(RegisterPetStateShowDismissPopUpLoading());
      emit(RegisterPetStateSuccess(pet));
    } on APIException catch (e) {
      emit(RegisterPetStateShowDismissPopUpLoading());
      emit(RegisterPetStateFail(e.message()));
    }
  }
}
