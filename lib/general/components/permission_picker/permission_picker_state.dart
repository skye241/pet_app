part of 'permission_picker_cubit.dart';

@immutable
abstract class PermissionPickerState {}

class PermissionPickerInitial extends PermissionPickerState {
  PermissionPickerInitial(this.selectedPermission);

  final List<String> selectedPermission;
}

class PermissionPickerCallBack extends PermissionPickerState {
  PermissionPickerCallBack(this.selectedPermission);

  final String selectedPermission;
}
