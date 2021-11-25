import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';

import '../main.dart';

class PetRepository {
  final NetworkService networkService = NetworkService();

  Future<List<PetType>>? getListPetType() async {
    final List<PetType> listPetType = <PetType>[];

    final APIResponse response =
        await networkService.callGET(Url.getListPetType);

    if (response.isOK ?? false) {
      response.data?[Constant.results].forEach((dynamic item) {
        listPetType.add(PetType.fromMap(item as Map<String, dynamic>));
      });
      print(response.data?[Constant.results]);
      print(listPetType);
      return listPetType;
    } else
      throw APIException(response);
  }

  Future<int> createPet(
      String? name, int? petTypeId, String? gender, String? birthday) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.name] = name;
    body[Constant.petTypeId] = petTypeId;
    body[Constant.gender] = gender;
    body[Constant.birthDate] = birthday;
    body[Constant.userId] = prefs?.getInt(Constant.userId);

    final APIResponse response =
        await networkService.callPOST(url: Url.createPet, body: body);

    if (response.isOK ?? false) {
      return getInt(Constant.petId, response.data as Map<String, dynamic>);
    } else
      throw APIException(response);
  }

  Future<List<Pet>> getListPet() async {
    final List<Pet> listPet = <Pet>[];

    final APIResponse response = await networkService.callGET(Url.getListPet +
        '?${Constant.userId}=${prefs!.getInt(Constant.userId)}');

    if (response.isOK ?? false) {
      response.data?.forEach((dynamic item) {
        listPet.add(Pet.fromMap(item as Map<String, dynamic>));
      });
      // print(response.data?[Constant.results]);
      print(listPet);
      return listPet;
    } else
      throw APIException(response);
  }
}
