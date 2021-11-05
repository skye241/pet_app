import 'dart:io';

import 'package:family_pet/genaral/librarys/file_storages/file_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'interfaces/i_pick_media_bloc.dart';

class PickMediaBloc extends IPickMediaBloc {
  @override
  Future<void> loadListMedia() async {
    filesGroup.clear();
    listPick = <File>{};
    final PermissionStatus permissionStatus =
        await Permission.storage.request();
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.granted) {
      List<File> files = <File>[];
      files = (await FileStorage.getFiles(
              specifyTypeFile: FileStorage.listTypeFileImage +
                  FileStorage.listTypeFileVideo))
          .map((String element) => File(element))
          .toList();
      files = _sortListFile(files);
      filesGroup = _groupFileFlowDateLastModify(files);
      publishSubjectListFile.sink.add(filesGroup);
    }
  }

  List<File> _sortListFile(List<File> list) {
    print(list.length);
    list.sort((File a, File b) {
      final DateTime dateTimeA = a.lastModifiedSync();
      final DateTime dateTimeB = b.lastModifiedSync();
      if (dateTimeA.year > dateTimeB.year)
        return -1;
      else if (dateTimeA.year < dateTimeB.year)
        return 1;
      else {
        if (dateTimeA.month > dateTimeB.month)
          return -1;
        else if (dateTimeA.month > dateTimeB.month)
          return 1;
        else {
          if (dateTimeA.day > dateTimeB.day)
            return -1;
          else if (dateTimeA.day > dateTimeB.day)
            return 1;
          else {
            return 0;
          }
        }
      }
    });
    return list;
  }

  Map<int, Map<int, Map<int, List<File>>>> _groupFileFlowDateLastModify(
      List<File> files) {
    final Map<int, Map<int, Map<int, List<File>>>> map =
        <int, Map<int, Map<int, List<File>>>>{};
    files = files.reversed.toList();
    //Nhom theo nam// Group year
    for (final File element in files) {
      final DateTime lastDateModified = element.lastModifiedSync();
      if (map[lastDateModified.year] == null) {
        map[lastDateModified.year] = <int, Map<int, List<File>>>{};
      }
      if (map[lastDateModified.year]![lastDateModified.month] == null) {
        map[lastDateModified.year]![lastDateModified.month] =
            <int, List<File>>{};
      }
      if (map[lastDateModified.year]![lastDateModified.month]![
              lastDateModified.day] ==
          null) {
        map[lastDateModified.year]![lastDateModified.month]![
            lastDateModified.day] = List<File>.empty(growable: true);
      }
      map[lastDateModified.year]![lastDateModified.month]![
              lastDateModified.day]!
          .add(element);
    }
    return map;
  }
}
