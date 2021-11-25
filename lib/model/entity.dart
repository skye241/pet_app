import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';

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
  final dynamic data;
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

class User {
  User({this.id, this.email, this.password});

  factory User.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return User();
    } else
      return User(
          id: getInt(Constant.id, data),
          email: getString(Constant.email, data),
          password: getString(Constant.password, data));
  }

  final int? id;
  final String? email;
  final String? password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.email: email,
      Constant.password: password,
    };
  }
}

class UserInfo {
  UserInfo({
    this.fullName,
    this.deviceKey,
    this.user,
    this.avatar,
    this.relationType,
    this.isActive,
  });

  factory UserInfo.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return UserInfo();
    } else
      return UserInfo(
        fullName: getString(Constant.fullName, data),
        deviceKey: getString(Constant.deviceKey, data),
        user: data[Constant.user] != null
            ? User.fromMap(data[Constant.user] as Map<String, dynamic>)
            : User(),
        avatar: Url.baseURLImage + getString(Constant.avatar, data),
        relationType: getString(Constant.relationType, data),
        isActive: getBool(Constant.isActive, data),
      );
  }

  final String? fullName;
  final String? deviceKey;
  final User? user;
  final String? avatar;
  final String? relationType;
  final bool? isActive;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.fullName: fullName,
      Constant.deviceKey: deviceKey,
      Constant.user: user!.toMap(),
    };
  }

  UserInfo copyWith({
    String? fullName,
    String? deviceKey,
    User? user,
    String? avatar,
    String? relationType,
    bool? isActive,
  }) {
    return UserInfo(
      fullName: fullName ?? this.fullName,
      deviceKey: deviceKey ?? this.deviceKey,
      user: user ?? this.user,
      avatar: avatar ?? this.avatar,
      relationType: relationType ?? this.relationType,
      isActive: isActive ?? this.isActive,
    );
  }
}

class Pet {
  Pet({
    this.id,
    this.name,
    this.user,
    this.petType,
    this.birthdate,
    this.gender,
  });

  factory Pet.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Pet();
    } else
      return Pet(
          id: getInt(Constant.id, data),
          name: getString(Constant.name, data),
          // user: User.fromMap(data[Constant.user] as Map<String, dynamic>),
          petType:
              PetType.fromMap(data[Constant.petType] as Map<String, dynamic>),
          birthdate: getString(Constant.birthDate, data),
          gender: getString(Constant.gender, data));
  }

  final int? id;
  final String? name;
  final User? user;
  final PetType? petType;
  final String? birthdate;
  final String? gender;
}

class Media {
  Media({
    this.id,
    this.mediaType,
    this.mediaName,
    this.share,
    this.file,
    this.user,
    this.createdAt,
    this.totalComment,
    this.isLiked,
  });

  factory Media.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Media();
    } else
      return Media(
        id: getInt(Constant.id, data),
        mediaName: getString(Constant.mediaName, data),
        mediaType: getString(Constant.mediaType, data),
        share: getString(Constant.share, data),
        file: Url.baseURLImage + getString(Constant.file, data),
        user: User.fromMap(data[Constant.user] as Map<String, dynamic>),
        createdAt: getString(Constant.createdAt, data),
        totalComment: getInt(Constant.totalComment, data),
        isLiked: getBool(Constant.isLiked, data),
      );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.mediaName: mediaName,
      Constant.mediaType: mediaType,
      Constant.share: share,
      Constant.file: file,
      Constant.user: user?.toMap(),
      Constant.createdAt: createdAt,
      Constant.totalComment: totalComment,
      Constant.isLiked: isLiked
    };
  }

  final int? id;
  final String? mediaType;
  final String? mediaName;
  final String? share;
  final String? file;
  final User? user;
  final String? createdAt;
  final int? totalComment;
  final bool? isLiked;

  Media copyWith({
    int? id,
    String? mediaType,
    String? mediaName,
    String? share,
    String? file,
    User? user,
    String? createdAt,
    int? totalComment,
    bool? isLiked,
  }) {
    return Media(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      mediaName: mediaName ?? this.mediaName,
      share: share ?? this.share,
      file: file ?? this.file,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      totalComment: totalComment ?? this.totalComment,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class Comment {
  Comment({
    this.id,
    this.media,
    this.user,
    this.content,
    this.userName,
    this.avatar,
  });

  factory Comment.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Comment(content: '');
    } else
      return Comment(
          id: getInt(Constant.id, data),
          media: Media.fromMap(data[Constant.media] as Map<String, dynamic>),
          content: getString(Constant.content, data),
          user: User.fromMap(data[Constant.user] as Map<String, dynamic>),
          userName: getString(Constant.userName, data),
          avatar: Url.baseURLImage + getString(Constant.avatar, data));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.media: media?.toMap(),
      Constant.content: content,
      Constant.user: user?.toMap()
    };
  }

  final int? id;
  final Media? media;
  final User? user;
  final String? content;
  final String? userName;
  final String? avatar;
}

class ShareEntity {
  ShareEntity({this.media, this.accepted, this.albumName});

  factory ShareEntity.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return ShareEntity();
    } else
      return ShareEntity(
          media: Media.fromMap(data[Constant.media] as Map<String, dynamic>),
          accepted: getBool(Constant.message, data),
          albumName: getString(Constant.albumName, data));
  }

  final Media? media;
  final bool? accepted;
  final String? albumName;
}

class Relationship {
  Relationship({this.user, this.target, this.type});

  factory Relationship.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Relationship();
    } else
      return Relationship(
        user: User.fromMap(data[Constant.user] as Map<String, dynamic>),
        target: User.fromMap(data[Constant.target] as Map<String, dynamic>),
        type: getString(Constant.relationType, data),
      );
  }

  final User? user;
  final User? target;
  final String? type;
}
