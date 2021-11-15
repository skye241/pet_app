import 'dart:io';

import 'package:family_pet/genaral/librarys/file_storages/file_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import 'interfaces/i_pick_media_bloc.dart';

class PickMediaBloc extends IPickMediaBloc {
  @override
  Future<void> loadListMedia() async {
    this.filesGroup.clear();
    listPick = new Set();
    currentPage = 1;
    totalPage = 1;

    if (Platform.isAndroid) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      print(permissionStatus);
      if (permissionStatus == PermissionStatus.granted) {
        List<File> files = [];
        files = (await FileStorage().getFiles(
                specifyTypeFile: FileStorage.listTypeFileImage +
                    FileStorage.listTypeFileVideo))
            .map((element) => File(element))
            .toList();
        files = _sortListFile(files);
        this.filesGroup = _groupFileFlowDateLastModify(files);
      }
    }
    if (Platform.isIOS) {
      bool result = await PhotoManager.requestPermission();
      PhotoManager.requestPermissionExtend();
      print(result);
      if (result) {
        List<File> files = [];
        List<AssetPathEntity> listAssetPath =
            await PhotoManager.getAssetPathList(
                onlyAll: true, type: RequestType.all); // Get all image
        List<AssetEntity> listAssetEntity = await listAssetPath
            .map((e) async {
              return e.assetList;
            })
            .toList()
            .first; //Take fist album because get only all album
        //The listAssetEntity was sort, so we aren't sort them
        for (AssetEntity assetEntity in listAssetEntity) {
          File? file = await assetEntity.file;
          file?.setLastModifiedSync(assetEntity.modifiedDateTime);
          file?.setLastModified(assetEntity.modifiedDateTime);
          print(file?.path);
          if (file != null) files.add(file);
        }
        this.filesGroup = _groupFileFlowDateLastModify(files);
      }
    }
    publishSubjectListFile.sink.add(this.filesGroup);
  }

  Future<void> getMore() async {}

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
