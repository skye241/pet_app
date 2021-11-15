import 'dart:io';
import 'dart:math';
import 'package:family_pet/model/enum.dart';
import 'package:rxdart/rxdart.dart';
abstract class IPickMediaBloc{

  //Page paginate
  int currentPage = 1;
  int totalPage =1;
  static const numberItemOnPage = 27;


  //Get list Media
  Set<File> listPick = <File>{};
  Map<int,Map<int,Map<int,List<File>>>> filesGroup = <int,Map<int,Map<int,List<File>>>>{};
  final PublishSubject<Map<int,Map<int,Map<int,List<File>>>>> publishSubjectListFile = PublishSubject<Map<int,Map<int,Map<int,List<File>>>>>();
  Stream<Map<int,Map<int,Map<int,List<File>>>>> get listFileStream => publishSubjectListFile.stream;
  Future<void> loadListMedia();
  Future<void> getMore();
  void pickFile(File file){
    listPick.add(file);
  }

  // Permission picker
  String currentPermissionPickMedia = PermissionPickMedia.family;





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