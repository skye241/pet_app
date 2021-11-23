import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_of_relatives_state.dart';

class ListOfRelativesCubit extends Cubit<ListOfRelativesState> {
  ListOfRelativesCubit() : super(ListOfRelativesInitial());
}
