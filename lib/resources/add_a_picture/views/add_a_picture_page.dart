import 'dart:io';

import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/add_a_picture/add_picture_cubit.dart';
import 'package:family_pet/resources/top_page/top_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => TopScreenPage()));
        } else if (state is AddPictureStateFail) {
          showMessage(context, 'Thông báo', state.message);
        }
      },
    );
  }

  Widget _body(BuildContext context, AddPictureInitial state) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 32,
              horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppStrings.of(context).textTitleAddAPicture,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 20,
              ),
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
                  width: 198,
                  height: 198,
                )
              else
                Image.file(state.image!),
              Container(
                height: 16,
              ),
              if (state.image == null)
                TextButton(
                    onPressed: () => getImageFromGallery(context, state),
                    child: Text(
                      'Thêm Ảnh',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppThemeData.color_primary_90),
                    ))
              else
                PermissionPickerWidget(
                    initPermission: PermissionPickMedia.family,
                    onPermissionPicked: (String per) =>
                        cubit.changeImage(state.image!, per)),
              const SizedBox(
                height: 126,
              ),
              ElevatedButton(
                  onPressed: () =>
                      cubit.createMedia(state.image!, state.permission),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child:
                        Text(AppStrings.of(context).textButtonChooseAPicture),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const TopScreenPage())),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppThemeData.color_black_40)),
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
      ),
    );
  }

  Future<void> getImageFromGallery(
      BuildContext context, AddPictureInitial state) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1500, maxWidth: 1500);
    if (pickedFile != null) {
      print(pickedFile);
      final File image = File(pickedFile.path);
      cubit.changeImage(image, state.permission);
    }
  }

}
