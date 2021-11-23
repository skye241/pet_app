import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';

class RelationshipRepository {
  final NetworkService networkService = NetworkService();

  Future<List<User>> getRelationship(String type) async {
    final APIResponse response = await networkService.callGET(Url
            .getRelationship +
        '?${Constant.userId}=${prefs!.getInt(Constant.userId)}&${Constant.relationType}=$type');
    if (response.isOK!) {
      final List<User> listUser = <User>[];
      for (final dynamic item in response.data[Constant.results] as List<dynamic>) {
        listUser.add(User.fromMap(item as Map<String, dynamic>));
      }
      return listUser;
    } else
      throw APIException(response);
  }
}
