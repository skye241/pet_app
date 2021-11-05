import 'package:rxdart/rxdart.dart';

enum EnumRelatives{friend, family}
abstract class IListRelativeBloc{
  EnumRelatives indexTab = EnumRelatives.family;
  PublishSubject<EnumRelatives> publishIndexTab = PublishSubject<EnumRelatives>();
  Stream<EnumRelatives> get indexRelativesStream => publishIndexTab.stream;
  PublishSubject<List<int>> publishSubjectListRelatives =  PublishSubject<List<int>>();
  Stream<List<int>> get listRelativesStream => publishSubjectListRelatives.stream;
  List<int> listUser = <int>[1,2,3,4,5];
  void changeIndex(EnumRelatives enumRelatives){
    //Change index
    indexTab = enumRelatives;
    //Change list
    //Submit
    submitChangeRelatives();
  }
  void submitChangeRelatives(){
    publishIndexTab.sink.add(indexTab);
    publishSubjectListRelatives.sink.add(listUser);
  }

}