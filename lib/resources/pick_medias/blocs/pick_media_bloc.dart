import 'dart:io';

import 'package:family_pet/genaral/librarys/file_storages/file_storage.dart';
import 'package:family_pet/resources/pick_medias/blocs/interfaces/i_pick_media_bloc.dart';
import 'package:permission_handler/permission_handler.dart';


class PickMediaBloc extends IPickMediaBloc {

  @override
   loadListMedia() async {
    this.filesGroup.clear();
    listPick = [];
    PermissionStatus permissionStatus = await Permission.storage.request();
    print(permissionStatus);
    if(permissionStatus == PermissionStatus.granted){
      List<File> files = (await  FileStorage.getFiles(specifyTypeFile: FileStorage.listTypeFileImage+FileStorage.listTypeFileVideo)).map((element) => File(element)).toList();
      files = _sortListFile(files);
      this.filesGroup = _groupFileFlowDateLastModify(files);
      publishSubjectListFile.sink.add(this.filesGroup);
    }

  }

  List<File> _sortListFile(List<File> list){
    list.sort((File a, File b){
      DateTime dateTimeA = a.lastModifiedSync();
      DateTime dateTimeB = b.lastModifiedSync();
      if(dateTimeA.year>dateTimeB.year)
        return -1;
      else if(dateTimeA.year<dateTimeB.year)
        return 1;
      else{
        if(dateTimeA.month> dateTimeB.month)
          return -1;
        else if(dateTimeA.month> dateTimeB.month)
          return 1;
        else {
          if(dateTimeA.day> dateTimeB.day)
            return -1;
          else if(dateTimeA.day> dateTimeB.day)
            return 1;
          else return 0;
        }
      }

    });
    return list;
  }

  Map<int,Map<int,Map<int,List<File>>>> _groupFileFlowDateLastModify(List<File> files){
    Map<int,Map<int,Map<int,List<File>>>> map  = new Map();
    files = files.reversed.toList();
    //Nhom theo nam// Group year
    files.forEach((element) {
      DateTime lastDateModified = element.lastModifiedSync();
      if(map[lastDateModified.year]==null){
        map[lastDateModified.year] = new Map();
      }
       if(map[lastDateModified.year]![lastDateModified.month]==null){
         map[lastDateModified.year]![lastDateModified.month] = new Map();
       }
       if(map[lastDateModified.year]![lastDateModified.month]![lastDateModified.day]==null){
         map[lastDateModified.year]![lastDateModified.month]![lastDateModified.day] = new List.empty(growable: true);
       }
      map[lastDateModified.year]![lastDateModified.month]![lastDateModified.day]!.add(element);
    });
    return map;
  }




}
