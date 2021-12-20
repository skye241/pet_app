import 'package:bloc/bloc.dart';
import 'package:family_pet/model/enum.dart';
import 'package:meta/meta.dart';

part 'permission_picker_state.dart';

class PermissionPickerCubit extends Cubit<PermissionPickerState> {
  // ignore: prefer_const_literals_to_create_immutables
  PermissionPickerCubit()
      : super(PermissionPickerInitial(<String>[PermissionPickMedia.onlyMe]));

  Future<void> changeType(
      String newPer, List<String> selected, bool chooseOne) async {
    if (!chooseOne) {
      if (newPer == PermissionPickMedia.onlyMe) {
        selected.removeWhere(
            (String permission) => permission != PermissionPickMedia.onlyMe);
      } else if (newPer != PermissionPickMedia.onlyMe &&
          selected.contains(PermissionPickMedia.onlyMe)) {
        selected.remove(PermissionPickMedia.onlyMe);
      }
      selected.add(newPer);

      if (selected.contains(PermissionPickMedia.friend) &&
          selected.contains(PermissionPickMedia.family)) {
        newPer = PermissionPickMedia.all;
      }
      emit(PermissionPickerCallBack(newPer));
      emit(PermissionPickerInitial(selected));
    } else {
      emit(PermissionPickerCallBack(newPer));
      emit(PermissionPickerInitial(<String>[newPer]));
    }
  }
}
