import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/add_a_picture/views/add_a_picture_page.dart';
import 'package:family_pet/resources/register_pet/register_pet_cubit.dart';
import 'package:family_pet/resources/register_pet/select_pet_type/select_pet_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPetPage extends StatefulWidget {
  const RegisterPetPage({Key? key}) : super(key: key);

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  final RegisterPetCubit cubit = RegisterPetCubit();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  @override
  void dispose() {
    cubit.close();
    nameController.dispose();
    birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPetCubit, RegisterPetState>(
        bloc: cubit,
        builder: (BuildContext context, RegisterPetState state) {
          if (state is RegisterPetInitial) {
            return _body(context, state);
          }
          return Container();
        });
  }

  Widget _body(BuildContext context, RegisterPetInitial state) {
    return Scaffold(
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
                  hintText: 'Tên thú cưng', label: 'Tên thú cưng'),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => const AddAPicturePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                        AppStrings.of(context).textButtonRegisterAndContinue),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppThemeData.color_black_40)),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.of(context).textSkipRegisterPet,
                    ),
                  )),
            ],
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
