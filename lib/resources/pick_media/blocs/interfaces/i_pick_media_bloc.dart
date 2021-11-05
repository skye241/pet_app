import 'dart:io';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
enum PermissonPickMedia{family,friend,onlyme}
abstract class IPickMediaBloc{
  //Get list Media
  Set<File> listPick = <File>{};
  Map<int,Map<int,Map<int,List<File>>>> filesGroup = <int,Map<int,Map<int,List<File>>>>{};
  final PublishSubject<Map<int,Map<int,Map<int,List<File>>>>> publishSubjectListFile = PublishSubject<Map<int,Map<int,Map<int,List<File>>>>>();
  Stream<Map<int,Map<int,Map<int,List<File>>>>> get listFileStream => publishSubjectListFile.stream;
  Future<void> loadListMedia();
  void pickFile(File file){
    listPick.add(file);
  }

  // Permission picker
  PermissonPickMedia currentPermissionPickMedia = PermissonPickMedia.family;





  // Control bottomsheet UI
  final double positionVerticalHide = 80;
  final double positionVerticalShow = 0;
  double currentPosition = 80;
  bool isShowBottomSheet = false;
  double positionOld = 80;
  final PublishSubject<double> _publishSubjectPositionBottomSheet =  PublishSubject<double>();
  Stream<double> get positionBottomSheetStream =>_publishSubjectPositionBottomSheet.stream;
  void updatePositionBottomSheet(double positionVertical){
    currentPosition = positionVertical;
    currentPosition =  max(currentPosition, positionVerticalShow);
    currentPosition =  min(currentPosition, positionVerticalHide);
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }
  void showBottomSheet(){
    currentPosition = positionVerticalShow;
    positionOld = positionVerticalShow;
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }
  void hideBottomSheet(){
    currentPosition = positionVerticalHide;
    positionOld = positionVerticalHide;
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }




}