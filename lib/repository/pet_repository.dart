import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/genaral/constant/constant.dart';
import 'package:family_pet/genaral/constant/url.dart';
import 'package:family_pet/model/entity.dart';

class PetRepository {
  Future<List<PetType>>? getListPetType() async {
    final List<PetType> listPetType = <PetType>[];

    final APIResponse response = await callGET(Url.getListPetType);

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
}
