part of 'list_of_relatives_cubit.dart';

@immutable
abstract class ListOfRelativesState {}

class ListOfRelativesInitial extends ListOfRelativesState {
  ListOfRelativesInitial(this.familyList, this.friendList);

  final List<UserInfo> familyList;
  final List<UserInfo> friendList;
}


class ListOfRelativesStateShowLoading extends ListOfRelativesState{}
class ListOfRelativesStateDismissLoading extends ListOfRelativesState{}

class ListOfRelativesStateShowMessage extends ListOfRelativesState {
  ListOfRelativesStateShowMessage(this.message);

  final String message;
}