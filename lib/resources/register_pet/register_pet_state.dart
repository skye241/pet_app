part of 'register_pet_cubit.dart';

@immutable
abstract class RegisterPetState {}

class RegisterPetInitial extends RegisterPetState {
  RegisterPetInitial(this.gender, this.selectedPetType);

  final String gender;
  final PetType selectedPetType;
}
