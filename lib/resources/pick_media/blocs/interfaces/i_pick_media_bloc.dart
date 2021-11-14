import 'dart:io';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
enum PermissonPickMedia{family,friend,onlyme}
abstract class IPickMediaBloc{

  //Page paginate
  int currentPage = 1;
  int totalPage =1;
  static const numberItemOnPage = 27;


  //Get list Media
  Set<File> listPick = new Set();
  Map<int,Map<int,Map<int,List<File>>>> filesGroup = new Map();
  final PublishSubject<Map<int,Map<int,Map<int,List<File>>>>> publishSubjectListFile = new PublishSubject();
  Stream<Map<int,Map<int,Map<int,List<File>>>>> get listFileStream => publishSubjectListFile.stream;
  Future<void> loadListMedia();
  Future<void> getMore();
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