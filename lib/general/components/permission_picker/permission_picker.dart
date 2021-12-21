import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker_cubit.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> defaultPermission = <String>[
  PermissionPickMedia.family,
  PermissionPickMedia.friend,
  PermissionPickMedia.onlyMe
];

class PermissionPickerWidget extends StatefulWidget {
  const PermissionPickerWidget(
      {Key? key,
      required this.initPermission,
      required this.onPermissionPicked,
      this.listPermission = defaultPermission,
      this.chooseOne = false})
      : super(key: key);

  final String initPermission;
  final ValueChanged<String> onPermissionPicked;
  final List<String> listPermission;
  final bool chooseOne;

  @override
  _PermissionPickerWidgetState createState() => _PermissionPickerWidgetState();
}

class _PermissionPickerWidgetState extends State<PermissionPickerWidget> {
  final PermissionPickerCubit cubit = PermissionPickerCubit();

  @override
  void initState() {
    cubit.initEvent(widget.initPermission);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionPickerCubit, PermissionPickerState>(
      bloc: cubit,
      listener: (BuildContext context, PermissionPickerState state) {
        if (state is PermissionPickerCallBack) {
          widget.onPermissionPicked(state.selectedPermission);
        }
      },
      child: BlocBuilder<PermissionPickerCubit, PermissionPickerState>(
          bloc: cubit,
          builder: (BuildContext context, PermissionPickerState state) {
            if (state is PermissionPickerInitial) {
              return _pickPermission(context, state);
            } else
              return Container();
          }),
    );
  }

  Widget _pickPermission(BuildContext context, PermissionPickerInitial state) {
    return Row(
      children: List<Widget>.generate(
          widget.listPermission.length,
          (int index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: index == 0
                          ? 0
                          : widget.listPermission.length > 2
                              ? 9
                              : 15,
                      right: index == widget.listPermission.length - 1
                          ? 0
                          : widget.listPermission.length > 2
                              ? 9
                              : 15),
                  child: _button(
                      widget.listPermission[index],
                      permissionToText(context, widget.listPermission[index]),
                      state),
                ),
              )),
    );
  }

  Widget _button(
      String permission, String content, PermissionPickerInitial state) {
    final bool isSelected = state.selectedPermission.contains(permission);
    return ElevatedButton(
      onPressed: () {
        // state.selectedPermission.add(permission);
        cubit.changeType(
            permission, state.selectedPermission, widget.chooseOne);
        // widget.onPermissionPicked(permission);
      },
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: isSelected ? Colors.white : AppThemeData.color_black_60),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  widget.listPermission.length > 2 ? 12 : 16)),
          primary: !isSelected
              ? AppThemeData.color_black_10
              : AppThemeData.color_primary_90),
    );
  }
}
