part of 'register_pet_cubit.dart';

@immutable
abstract class RegisterPetState {}

class RegisterPetInitial extends RegisterPetState {
  RegisterPetInitial(this.gender, this.selectedPetType);

  final String gender;
  final PetType selectedPetType;
}

class RegisterPetStateShowPopUpLoading extends RegisterPetState{}
class RegisterPetStateShowDismissPopUpLoading extends RegisterPetState{}
class RegisterPetStateSuccess extends RegisterPetState{
  RegisterPetStateSuccess(this.pet);

  final Pet pet;
}
class RegisterPetStateFail extends RegisterPetState{
  RegisterPetStateFail(this.message);

  final String message;
}