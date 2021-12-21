import 'package:bloc/bloc.dart';
import 'package:family_pet/model/enum.dart';
import 'package:meta/meta.dart';

part 'permission_picker_state.dart';

class PermissionPickerCubit extends Cubit<PermissionPickerState> {
  // ignore: prefer_const_literals_to_create_immutables
  PermissionPickerCubit()
      : super(PermissionPickerInitial(<String>[PermissionPickMedia.onlyMe]));

  Future<void> initEvent(String initPermission) async {
    final List<String> selected = <String>[];
    if (initPermission == PermissionPickMedia.all) {
      selected.addAll(
          <String>[PermissionPickMedia.family, PermissionPickMedia.friend]);
    } else {
      selected.add(initPermission);
    }
    // if (selected.contains(PermissionPickMedia.friend) &&
    //     selected.contains(PermissionPickMedia.family)) {
    //   initPermission = PermissionPickMedia.all;
    // }
    emit(PermissionPickerCallBack(initPermission));
    emit(PermissionPickerInitial(selected));
  }

  Future<void> changeType(
      String newPer, List<String> selected, bool chooseOne) async {
    print(newPer + '===in bloc');
    if (!chooseOne) {
      if (newPer == PermissionPickMedia.onlyMe) {
        selected.clear();
        selected.add(newPer);
        print(selected);
      } else if (newPer != PermissionPickMedia.onlyMe &&
          selected.contains(PermissionPickMedia.onlyMe)) {
        print('in here');
        selected.remove(PermissionPickMedia.onlyMe);
        selected.add(newPer);
      } else if (newPer != PermissionPickMedia.onlyMe &&
          selected.contains(newPer)) {
        selected.remove(newPer);
      } else {
        selected.add(newPer);
      }

      if (selected.contains(PermissionPickMedia.friend) &&
          selected.contains(PermissionPickMedia.family)) {
        newPer = PermissionPickMedia.all;
      } else if (selected.isEmpty) {
        newPer = PermissionPickMedia.onlyMe;
        selected.add(PermissionPickMedia.onlyMe);
      } else {
        newPer = selected.first;
      }

      emit(PermissionPickerCallBack(newPer));
      emit(PermissionPickerInitial(selected));
    } else {
      emit(PermissionPickerCallBack(newPer));
      emit(PermissionPickerInitial(<String>[newPer]));
    }
  }
}
