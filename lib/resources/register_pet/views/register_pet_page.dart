import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/components/date_formatter.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/register_pet/register_pet_cubit.dart';
import 'package:family_pet/resources/register_pet/select_pet_type/select_pet_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPetPage extends StatefulWidget {
  const RegisterPetPage({Key? key, required this.isFirstStep})
      : super(key: key);
  final bool isFirstStep;

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  final RegisterPetCubit cubit = RegisterPetCubit();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode birthNode = FocusNode();

  @override
  void dispose() {
    cubit.close();
    nameController.dispose();
    birthController.dispose();
    nameNode.dispose();
    birthNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterPetCubit, RegisterPetState>(
      bloc: cubit,
      listener: (BuildContext context, RegisterPetState state) {
        if (state is RegisterPetStateShowPopUpLoading) {
          showPopUpLoading(context);
        } else if (state is RegisterPetStateShowDismissPopUpLoading) {
          Navigator.pop(context);
        } else if (state is RegisterPetStateSuccess) {
          if (widget.isFirstStep) {
            Navigator.pushReplacementNamed(context, RoutesName.addAPicture);
          } else
            Navigator.pop(context, state.pet);
        } else if (state is RegisterPetStateFail) {
          showMessage(context, AppStrings.of(context).notice, state.message);
        }
      },
      child: BlocBuilder<RegisterPetCubit, RegisterPetState>(
        bloc: cubit,
        buildWhen: (RegisterPetState prev, RegisterPetState current) {
          if (current is! RegisterPetInitial) {
            return false;
          } else
            return true;
        },
        builder: (BuildContext context, RegisterPetState state) {
          if (state is RegisterPetInitial) {
            return _body(context, state);
          } else
            return const Scaffold();
        },
      ),
    );
  }

  Widget _body(BuildContext context, RegisterPetInitial state) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).padding.top + 32,
                  horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppStrings.of(context).textTitleRegisterPet,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (widget.isFirstStep)
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
                              backgroundColor: AppThemeData.color_neutral_25,
                              child: const Text(
                                '3',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                        currentStep: 3,
                        colorDone: AppThemeData.color_primary_30,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        colorWait: AppThemeData.color_neutral_25,
                        sizePen: 4),
                  const SizedBox(
                    height: 22,
                  ),
                  ComponentHelper.textField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return AppStrings.of(context).textErrorEmptyPetName;
                        } else
                          return null;
                      },
                      focusNode: nameNode,
                      hintText: AppStrings.of(context).textLabelFieldNamePet,
                      label: AppStrings.of(context).textLabelFieldNamePet),
                  const SizedBox(
                    height: 18,
                  ),
                  SelectPetTypeWidget(
                      onPetTypeSelected: (PetType petType) =>
                          cubit.update(state.gender, petType)),
                  const SizedBox(
                    height: 18,
                  ),
                  _chooseSexual(context, state),
                  const SizedBox(
                    height: 18,
                  ),
                  ComponentHelper.textField(
                      hintText: 'YYYY/MM/DD',
                      controller: birthController,
                      focusNode: birthNode,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11),
                        DateFormatter(DateTime.now()),
                      ],
                      validator: (String? value) {
                        if (value != null && value.isNotEmpty) {
                          try {
                            print(value);
                            final DateTime? dateTime = DateTime.parse(value);
                            print(dateTime);
                            if (dateTime == null) {
                              return AppStrings.of(context)
                                  .textErrorWrongDateFormat;
                            } else
                              return null;
                          } on FormatException {
                            return AppStrings.of(context)
                                .textErrorWrongDateFormat;
                          }
                        }
                        return null;
                      },
                      label: AppStrings.of(context).textLabelFieldBirthday,
                      suffix: const Icon(
                        Icons.calendar_today_rounded,
                        color: AppThemeData.color_black_80,
                        size: 20,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          fixedSize: const Size(double.maxFinite, 50)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.createPet(nameController.text, state.gender,
                              state.selectedPetType, birthController.text);
                        } else
                          print('fail');
                      },
                      child: Text(widget.isFirstStep
                          ? AppStrings.of(context).textButtonRegisterAndContinue
                          : AppStrings.of(context).textButtonContinue)),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.isFirstStep)
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, RoutesName.addAPicture),
                      style: ElevatedButton.styleFrom(
                          primary: AppThemeData.color_black_40,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          fixedSize: const Size(double.maxFinite, 50)),
                      child: Text(
                        AppStrings.of(context).textSkipRegisterPet,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chooseSexual(BuildContext context, RegisterPetInitial state) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppThemeData.color_black_10),
          borderRadius: BorderRadius.circular(6.0)),
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.of(context).textLabelFieldSexual,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: AppThemeData.color_black_60),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile<String?>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    activeColor: AppThemeData.color_primary_90,
                    title: Text(AppStrings.of(context).textLabelChooseMale),
                    value: Gender.male,
                    groupValue: state.gender,
                    onChanged: (String? value) => cubit.update(
                        value ?? Gender.male, state.selectedPetType)),
              ),
              Expanded(
                child: RadioListTile<String?>(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    activeColor: AppThemeData.color_primary_90,
                    title: Text(AppStrings.of(context).textLabelChooseFemale),
                    value: Gender.female,
                    groupValue: state.gender,
                    onChanged: (String? value) => cubit.update(
                        value ?? Gender.male, state.selectedPetType)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
