import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/resources/fast_register_user/register_fast_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFastUserPage extends StatefulWidget {
  const RegisterFastUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterFastUserPage> createState() => _RegisterFastUserPageState();
}

class _RegisterFastUserPageState extends State<RegisterFastUserPage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode nameNode = FocusNode();
  final RegisterFastCubit cubit = RegisterFastCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterFastCubit, RegisterFastState>(
        child: body(context),
        bloc: cubit,
        listener: (BuildContext context, RegisterFastState state) {
          if (state is RegisterFastStatePopUpLoading) {
            showPopUpLoading(context);
          } else if (state is RegisterFastStateDismissPopUpLoading) {
            Navigator.pop(context);
          } else if (state is RegisterFastStateSuccess) {
            Navigator.pushReplacementNamed(context, RoutesName.registerPet, arguments: <String, dynamic>{
              Constant.isFirstStep: true
            });
          } else if (state is RegisterFastStateFail) {
            showMessage(context, AppStrings.of(context).notice, state.message);
          }
        });
  }

  Widget body(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top + 32,
                horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppStrings.of(context).textTitleRegisterUser,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 40,
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
                          backgroundColor: AppThemeData.color_neutral_25,
                          child: const Text(
                            '2',
                            style: TextStyle(color: Colors.white),
                          )),
                      ComponentHelper.itemStep(
                          backgroundColor: AppThemeData.color_neutral_25,
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                    currentStep: 2,
                    colorDone: AppThemeData.color_primary_30,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    colorWait: AppThemeData.color_neutral_25,
                    sizePen: 4),
                const SizedBox(
                  height: 22,
                ),
                Image.asset(
                  'assets/images/img_register_1.png',
                  width: 289,
                  height: 226,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(AppStrings.of(context).textLabelFieldNameUser,
                        style: Theme.of(context).textTheme.bodyText2),
                    Text(AppStrings.of(context).textSubLabelFieldNameUser,
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Form(
                  key: formKey,
                  child: ComponentHelper.textField(
                      controller: nameController,
                      focusNode: nameNode,
                      onEditingComplete: onRegister,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.of(context).textErrorNameMessage;
                        } else
                          return null;
                      },
                      hintText: AppStrings.of(context).textLabelFieldNameUser),
                ),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                    onPressed: onRegister,
                    //     () {

                    // },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(AppStrings.of(context).textButtonContinue),
                    )),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, RoutesName.signInPage),
                    style: ElevatedButton.styleFrom(
                        primary: AppThemeData.color_black_40),
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.of(context).textButtonHadAccount,
                      ),
                    )),
                const SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Text(
                        AppStrings.of(context).textRuleService,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        AppStrings.of(context).textPolicyProtected,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onRegister() {
    if (formKey.currentState!.validate()) {
      cubit.registerUser(nameController.text);
    }
  }
}
