import 'package:bloc/bloc.dart';
import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/pet_repository.dart';
import 'package:meta/meta.dart';

part 'select_pet_type_state.dart';

class SelectPetTypeCubit extends Cubit<SelectPetTypeState> {
  SelectPetTypeCubit() : super(SelectPetTypeInitial());

  final PetRepository petRepository = PetRepository();

  Future<void> getListPet() async {
    try {
      emit(SelectPetTypeStateLoading());
      final List<PetType>? listPetType = await petRepository.getListPetType();
      emit(SelectPetTypeStateLoaded(
          listPetType ?? <PetType>[], listPetType!.isNotEmpty? listPetType.first : PetType()));
    } on APIException catch (e) {
      print(e.message());
      emit(SelectPetTypeStateError(e.message()));
    }
  }

  Future<void> selectPetType(PetType petType, List<PetType> listPetType) async {
    emit(SelectPetTypeStateLoaded(listPetType, petType));
  }
}
