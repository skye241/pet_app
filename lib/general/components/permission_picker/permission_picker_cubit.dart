import 'package:bloc/bloc.dart';
import 'package:family_pet/model/enum.dart';
import 'package:meta/meta.dart';

part 'permission_picker_state.dart';

class PermissionPickerCubit extends Cubit<PermissionPickerState> {
  PermissionPickerCubit() : super(PermissionPickerInitial(PermissionPickMedia.onlyMe));

  Future<void> changeType (String per) async {
    emit(PermissionPickerInitial(per));
  }
}
