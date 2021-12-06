import 'dart:io';

import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_account_cubit.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key, required this.userInfo}) : super(key: key);

  final UserInfo userInfo;

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final EditAccountCubit cubit = EditAccountCubit();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController albumNameController = TextEditingController();
  final FocusNode albumNameNode = FocusNode();
  final FocusNode fullNameNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fullNameController.text = widget.userInfo.fullName!;
    albumNameController.text = widget.userInfo.albumName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppStrings.of(context).textProfileButtonEditAccount),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                ),
                Stack(
                  children: <Widget>[
                    BlocBuilder<EditAccountCubit, EditAccountState>(
                      bloc: cubit,
                      buildWhen:
                          (EditAccountState prev, EditAccountState state) {
                        if (state is EditAccountStateShowPopUpLoading) {
                          showPopUpLoading(context);
                          return false;
                        } else if (state
                            is EditAccountStateDismissPopUpLoading) {
                          Navigator.pop(context);
                          return false;
                        } else if (state is EditAccountStateSuccess) {
                          showMessage(context, AppStrings.of(context).notice,
                              AppStrings.of(context).successUpdate,
                              actions: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppStrings.of(context).close)));
                          return false;
                        } else if (state is EditAccountStateFail) {
                          showMessage(context, AppStrings.of(context).notice,
                              state.message);
                          return false;
                        } else
                          return true;
                      },
                      builder: (BuildContext context, EditAccountState state) {
                        if (state is EditAccountInitial) {
                          if (state.avatar == null) {
                            return Center(
                              child: Container(
                                height: 80,
                                // width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppThemeData.color_black_10,
                                  image: widget.userInfo.avatar!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(Url.baseURLImage +
                                              widget.userInfo.avatar!))
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/img_user.png')),
                                ),
                              ),
                            );
                          } else
                            return Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppThemeData.color_black_10,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(state.avatar!)),
                                ),
                              ),
                            );
                        }
                        return Container();
                      },
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width/2 - 43,
                      top: 17,
                      // alignment: Alignment.bottomCenter,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white.withOpacity(0.75),
                        iconSize: 40,
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () => getImageFromGallery(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      accountStatus(context, widget.userInfo.status!),
                      style: TextStyle(
                          color: widget.userInfo.status != AccountStatus.active
                              ? AppThemeData.color_warning
                              : AppThemeData.color_black_80),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (widget.userInfo.status != AccountStatus.active)
                      const Icon(
                        Icons.warning_amber_outlined,
                        color: AppThemeData.color_warning,
                      )
                    else
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppThemeData.color_primary_90,
                      ),
                  ],
                ),
                Container(
                  height: 32,
                ),
                Row(
                  children: <Widget>[
                    Text(AppStrings.of(context).textLabelFieldNameUser,
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                Container(
                  height: 8,
                ),
                ComponentHelper.textField(
                    controller: fullNameController,
                    focusNode: fullNameNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(albumNameNode);
                    },
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.of(context).textErrorNameMessage;
                      } else
                        return null;
                    },
                    hintText: AppStrings.of(context).textLabelFieldNameUser),
                Container(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Text(AppStrings.of(context).albumName,
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                Container(
                  height: 8,
                ),
                ComponentHelper.textField(
                    controller: albumNameController,
                    focusNode: albumNameNode,
                    onEditingComplete: () => onUpdate(context),
                    keyboardType: TextInputType.name,
                    // validator: (String? value) {
                    //   if (value == null || value.isEmpty) {
                    //     return AppStrings.of(context).textErrorNameMessage;
                    //   } else
                    //     return null;
                    // },
                    hintText: AppStrings.of(context).albumName),
                // Flexible(child: Container()),
                Container(
                  height: 40,
                ),


              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => onUpdate(context),
                child: Text(
                    AppStrings.of(context).textProfileButtonEditAccount)),
          ),
        ) ,
      ),
    );
  }

  void onUpdate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      cubit.updateUser(
          cubit.defaultFile, fullNameController.text, albumNameController.text);
    }
  }

  String accountStatus(BuildContext context, String status) {
    switch (status) {
      case AccountStatus.unlink:
        return AppStrings.of(context).textProfileNotLinkAccount;
      case AccountStatus.inactive:
        return AppStrings.of(context).textProfileNotActivate;
      case AccountStatus.active:
        return AppStrings.of(context).textProfileActivate;
      default:
        return AppStrings.of(context).textProfileNotLinkAccount;
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1500, maxWidth: 1500);
      if (pickedFile != null) {
        print(pickedFile);
        final File image = File(pickedFile.path);
        cubit.updateImage(image);
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
