import 'dart:io';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
enum PermissonPickMedia{family,friend,onlyme}
abstract class IPickMediaBloc{
  //Get list Media
  List<File> listPick = [];
  Map<int,Map<int,Map<int,List<File>>>> filesGroup = new Map();
  final PublishSubject<Map<int,Map<int,Map<int,List<File>>>>> publishSubjectListFile = new PublishSubject();
  Stream<Map<int,Map<int,Map<int,List<File>>>>> get listFileStream => publishSubjectListFile.stream;
  loadListMedia();
  void pickFile(File file){
    listPick.add(file);
  }

  // Permission picker
  PermissonPickMedia currentPermissionPickMedia = PermissonPickMedia.family;








  // Control bottomsheet UI
  final double positionVerticalHide = 150;
  final double positionVerticalShow = 0;
  double currentPosition = 150;
  bool isShowBottomSheet = false;
  double positionOld = 150;
  PublishSubject<double> _publishSubjectPositionBottomSheet = new PublishSubject();
  Stream<double> get positionBottomSheetStream =>_publishSubjectPositionBottomSheet.stream;
  updatePotsitionBottomSheet(double positionVertical){
    currentPosition = positionVertical;
    currentPosition =  max(currentPosition, positionVerticalShow);
    currentPosition =  min(currentPosition, positionVerticalHide);
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }
  showBottomSheet(){
    currentPosition = positionVerticalShow;
    positionOld = positionVerticalShow;
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }
  hideBottomSheet(){
    currentPosition = positionVerticalHide;
    positionOld = positionVerticalHide;
    _publishSubjectPositionBottomSheet.sink.add(currentPosition);
  }




}