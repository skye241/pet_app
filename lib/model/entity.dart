import 'package:family_pet/genaral/constant/constant.dart';

/// Các hàm lấy dữ liệu - Tools
/// Lấy dữ liệu dạng string từ map mặc định ''
String getString(String key, Map<String, dynamic>? data) {
  String result = '';
  if (data == null) {
    result = '';
  } else if (data[key] == null) {
    result = '';
  } else if (!data.containsKey(key)) {
    result = '';
  } else {
    result = data[key].toString();
  }
  return result;
}

///Lấy dữ liệu int từ map mặc định 0
int getInt(String key, Map<String, dynamic>? data) {
  int result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = int.parse(data[key].toString());
  }
  return result;
}

/// Lấy dữ liệu double từ map mặc định 0
double getDouble(String key, Map<String, dynamic>? data) {
  double result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = double.parse(data[key].toString());
  }
  return result;
}

/// lấy dữ liệu bool từ map mặc định false
bool getBool(String key, Map<String, dynamic>? data) {
  bool result = false;
  if (data == null) {
    result = false;
  } else if (data[key] == null) {
    result = false;
  } else if (!data.containsKey(key)) {
    result = false;
  } else {
    result = data[key] as bool;
  }
  return result;
}

/// Lấy list double entity
List<double> getListDouble(String key, Map<String, dynamic>? data) {
  final List<double> result = <double>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as double);
  });
  return result;
}

/// Get list int entity
List<int> getListInt(String key, Map<String, dynamic>? data) {
  final List<int> result = <int>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as int);
  });
  return result;
}

/// Get list String entity
List<String> getListString(String key, Map<String, dynamic>? data) {
  final List<String> result = <String>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  } else
    data[key].forEach((dynamic item) {
      result.add(item as String);
    });
  return result;
}

/// parse List PetType
List<PetType> parseListPetType(String key, Map<String, dynamic>? data) {
  final List<PetType> result = <PetType>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  (data[key]).forEach((dynamic item) {
    result.add(PetType.fromMap(item as Map<String, dynamic>));
  });
  return result;
}

class APIResponse {
  APIResponse({this.isOK, this.code, this.data, this.message});

  final bool? isOK;
  final int? code;
  final Map<String,dynamic>? data;
  final String? message;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.ok: isOK,
      Constant.code: code,
      Constant.data: data,
      Constant.message: message,
    };
  }
}

class PetType {
  PetType({this.id, this.name, this.species, this.info});

  factory PetType.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return PetType();
    }
    return PetType(
      id: getInt(Constant.id, data),
      name: getString(Constant.name, data),
      species: getString(Constant.species, data),
      info: getString(Constant.info, data),
    );
  }

  final int? id;
  final String? name;
  final String? species;
  final String? info;


}
