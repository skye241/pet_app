import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage{

  static List<String> listTypeFileVideo = [".mp4",".gif",".wmv",".hevc",".avi",".mov",".f4v",".mkv",".ts",".3gp",".mpeg-2",".webm",".vob",".flv",".divx"];
  static List<String> listTypeFileImage = [".jpg",".jpeg",".png",".gif",".tiff",".psd",".eps",".ai",".raw"];


  static Future<List<String>> getFiles({List<String> specifyTypeFile = const []})async{
    List<String> list = new List.empty(growable:  true);
    Directory? directory = await getExternalStorageDirectory();
    print(directory);
    print(directory!.parent.parent.parent.parent);
    if(directory!=null)
    list = _queryFolder(directory.parent.parent.parent.parent,specifyTypeFile).toList();
    else    throw "Directory was null, check permisson";
    return list;
  }
  static Iterable<String> _queryFolder(Directory directory, List<String> specifyTypeFile)sync*{
    if(directory.path!= "/storage/emulated/0/Android")
    for(FileSystemEntity elementFileSystemEntity in   directory.listSync()){
        if(elementFileSystemEntity.path.contains(".")){
        if(specifyTypeFile.isEmpty){
          yield elementFileSystemEntity.path;
        }
        else{
          for(String element in specifyTypeFile){
            if(elementFileSystemEntity.path.endsWith("${element}")){
              yield elementFileSystemEntity.path;
            }
          }
        }
      }
      else{
        print("object: ${elementFileSystemEntity.path}");
        yield* _queryFolder(Directory(elementFileSystemEntity.path), specifyTypeFile);
      }
    }
  }

}