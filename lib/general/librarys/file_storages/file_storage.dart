import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class FileStorage {
  // static List<String> listTypeFileVideo = [".mp4",".gif",".wmv",".hevc",".avi",".mov",".f4v",".mkv",".ts",".3gp",".mpeg-2",".webm",".vob",".flv",".divx"];
  static const List<String> listTypeFileVideo = <String>[
    '.mp4',
  ];
  // static List<String> listTypeFileImage = [".jpg",".jpeg",".png",".gif",".tiff",".psd",".eps",".ai",".raw"];
  static const List<String> listTypeFileImage = <String>['.jpg', '.png'];

  Future<List<String>> getFiles(
      {List<String> specifyTypeFile = const <String>[]}) async {
    List<String> list = List<String>.empty(growable: true);
    if (Platform.isAndroid) {
      final Directory? directory = await getExternalStorageDirectory();
      print(directory);
      print(directory!.parent.parent.parent.parent);
      if (directory != null)
        list =
            _queryFolder(directory.parent.parent.parent.parent, specifyTypeFile)
                .toList();
      else
        throw 'Directory was null, check permisson';
    }
    return list;
  }

  static Iterable<String> _queryFolder(
      Directory directory, List<String> specifyTypeFile) sync* {
    for (FileSystemEntity elementFileSystemEntity in directory.listSync()) {
      try {
        if (elementFileSystemEntity.path.contains(".")) {
          if (specifyTypeFile.isEmpty) {
            yield elementFileSystemEntity.path;
          } else {
            for (final String element in specifyTypeFile) {
              if (elementFileSystemEntity.path.endsWith(element)) {
                yield elementFileSystemEntity.path;
              }
            }
          }
        } else {
          print('object: ${elementFileSystemEntity.path}');
          yield* _queryFolder(
              Directory(elementFileSystemEntity.path), specifyTypeFile);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
