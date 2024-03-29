import 'dart:io';

import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/add_a_picture/add_picture_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddAPicturePage extends StatefulWidget {
  const AddAPicturePage({Key? key}) : super(key: key);

  @override
  State<AddAPicturePage> createState() => _AddAPicturePageState();
}

class _AddAPicturePageState extends State<AddAPicturePage> {
  final AddPictureCubit cubit = AddPictureCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPictureCubit, AddPictureState>(
      child: BlocBuilder<AddPictureCubit, AddPictureState>(
        bloc: cubit,
        buildWhen: (AddPictureState prev, AddPictureState current) {
          if (current is! AddPictureInitial) {
            return false;
          } else
            return true;
        },
        builder: (BuildContext context, AddPictureState state) {
          if (state is AddPictureInitial) {
            return _body(context, state);
          } else
            return Container();
        },
      ),
      bloc: cubit,
      listener: (BuildContext context, AddPictureState state) {
        if (state is AddPictureStateShowLoading) {
          showPopUpLoading(context);
        } else if (state is AddPictureStateDismissLoading) {
          Navigator.pop(context);
        } else if (state is AddPictureStateSuccess) {
          Navigator.pushReplacementNamed(context, RoutesName.topPage);
        } else if (state is AddPictureStateFail) {
          showMessage(context, AppStrings.of(context).notice, state.message);
        }
      },
    );
  }

  Widget _body(BuildContext context, AddPictureInitial state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).textTitleAddAPicture,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ComponentHelper.stepByStepHorizontal(
                children: <Widget>[
                  ComponentHelper.itemStep(
                      backgroundColor: AppThemeData.color_main,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )),
                  ComponentHelper.itemStep(
                      backgroundColor: AppThemeData.color_main,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )),
                  ComponentHelper.itemStep(
                      backgroundColor: AppThemeData.color_main,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )),
                ],
                currentStep: 4,
                colorDone: AppThemeData.color_primary_30,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                colorWait: AppThemeData.color_neutral_25,
                sizePen: 4),
            const SizedBox(
              height: 147,
            ),
            if (state.image == null)
              Image.asset(
                'assets/images/img_album.png',
                // width: 198,
                height: 198,
              )
            else
              Stack(
                children: <Widget>[
                  Image.file(
                    state.image!,
                    height: 198,
                  ),
                  Positioned(
                      right: 16,
                      top: 5,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.redAccent,
                        ),
                        onTap: () => cubit.update(null, state.permission),
                      ))
                ],
              ),
            Container(
              height: 16,
            ),
            if (state.image == null)
              TextButton(
                  onPressed: () => getImageFromGallery(context, state),
                  child: Text(
                    AppStrings.of(context).textButtonAddMedia,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppThemeData.color_primary_90),
                  ))
            else
              PermissionPickerWidget(
                  initPermission: PermissionPickMedia.family,
                  onPermissionPicked: (String per) =>
                      cubit.update(state.image!, per)),
            Expanded(
              child: Container(
                  // height: double.infinity,
                  ),
            ),
            ElevatedButton(
                onPressed: state.image != null
                    ? () => cubit.createMedia(
                        state.image!, state.permission, context)
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(AppStrings.of(context).textButtonChooseAPicture),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, RoutesName.topPage),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppThemeData.color_black_40)),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.of(context).textButtonSkipChooseAPicture,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> getImageFromGallery(
      BuildContext context, AddPictureInitial state) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1500, maxWidth: 1500);
      if (pickedFile != null) {
        print(pickedFile);
        final File image = File(pickedFile.path);
        cubit.update(image, state.permission);
      }
    } on PlatformException catch (e) {
      print(e.code);
      if (e.code == 'photo_access_denied') {
        showMessage(context, AppStrings.of(context).notice,
            AppStrings.of(context).textErrorNoPermission);
      }
    }
  }
}
