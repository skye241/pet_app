part of 'select_pet_type_cubit.dart';

@immutable
abstract class SelectPetTypeState {}

class SelectPetTypeInitial extends SelectPetTypeState {}

class SelectPetTypeStateLoading extends SelectPetTypeState {}

class SelectPetTypeStateError extends SelectPetTypeState {
  SelectPetTypeStateError(this.message);

  final String message;

}

class SelectPetTypeStateLoaded extends SelectPetTypeState {
  SelectPetTypeStateLoaded(this.listPetType, this.selectedPetType);

  final List<PetType> listPetType;
  final PetType selectedPetType;
}

