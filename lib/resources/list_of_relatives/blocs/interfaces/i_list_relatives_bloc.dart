import 'package:rxdart/rxdart.dart';

enum EnumRelatives{friend, family}
abstract class IListRelativeBloc{
  EnumRelatives indexTab = EnumRelatives.family;
  PublishSubject<EnumRelatives> publishIndexTab = new PublishSubject();
  Stream<EnumRelatives> get indexRelativesStream => publishIndexTab.stream;
  PublishSubject<List> publishSubjectListRelatives = new PublishSubject();
  Stream<List> get listRelativesStream => publishSubjectListRelatives.stream;
  List listUser = [1,2,3,4,5];
  changeIndex(EnumRelatives enumRelatives){
    //Change index
    indexTab = enumRelatives;
    //Change list
    //Submit
    submitChangeRelatives();
  }
  submitChangeRelatives(){
    publishIndexTab.sink.add(indexTab);
    publishSubjectListRelatives.sink.add(listUser);
  }

}