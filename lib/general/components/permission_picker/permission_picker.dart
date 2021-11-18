import 'package:auto_size_text/auto_size_text.dart';
import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker_cubit.dart';
import 'package:family_pet/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionPickerWidget extends StatefulWidget {
  const PermissionPickerWidget(
      {Key? key,
      required this.initPermission,
      required this.onPermissionPicked})
      : super(key: key);

  final String initPermission;
  final ValueChanged<String> onPermissionPicked;

  @override
  _PermissionPickerWidgetState createState() => _PermissionPickerWidgetState();
}

class _PermissionPickerWidgetState extends State<PermissionPickerWidget> {
  final PermissionPickerCubit cubit = PermissionPickerCubit();

  @override
  void initState() {
    cubit.changeType(widget.initPermission);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionPickerCubit, PermissionPickerState>(
        bloc: cubit,
        builder: (BuildContext context, PermissionPickerState state) {
          if (state is PermissionPickerInitial) {
            return _pickPermission(context, state);
          } else
            return Container();
        });
  }

  Widget _pickPermission(BuildContext context, PermissionPickerInitial state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _button(PermissionPickMedia.family,
            AppStrings.of(context).textPickMediaButtonFamily, state),
        Container(
          width: 18,
        ),
        _button(PermissionPickMedia.friend,
            AppStrings.of(context).textPickMediaButtonFriend, state),
        Container(
          width: 18,
        ),
        _button(PermissionPickMedia.onlyMe,
            AppStrings.of(context).textPickMediaButtonOnlyMe, state),
      ],
    );
  }

  Widget _button(
      String permission, String content, PermissionPickerInitial state) {
    final bool isSelected = state.selectedPermission == permission;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          cubit.changeType(permission);
          widget.onPermissionPicked(permission);
        },
        child: AutoSizeText(
          content,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: isSelected ? Colors.white : AppThemeData.color_black_60),
          maxLines: 1,
        ),
        style: ElevatedButton.styleFrom(
            primary: !isSelected
                ? AppThemeData.color_black_10
                : AppThemeData.color_primary_90),
      ),
    );
  }
}
