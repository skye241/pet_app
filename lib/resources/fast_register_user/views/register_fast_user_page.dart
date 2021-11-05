import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/resources/register_pet/views/register_pet_page.dart';
import 'package:flutter/material.dart';

class RegisterFastUserPage extends StatefulWidget {
  const RegisterFastUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterFastUserPage> createState() => _RegisterFastUserPageState();
}

class _RegisterFastUserPageState extends State<RegisterFastUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
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
              const Image(
                image: AssetImage(
                    'assets/images/img_register_1.png',),
                width: 289,
                height: 226,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: AppStrings.of(context).textLabelFieldNameUser,
                        style: Theme.of(context).textTheme.bodyText2),
                    TextSpan(
                        text: AppStrings.of(context)
                            .textSubLabelFieldNameUser,
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
                ),
              ),
              const SizedBox(height: 18,),
              Form(
                child: ComponentHelper.textField(hintText: AppStrings.of(context).textLabelFieldNameUser),
              ),
              const SizedBox(
                height: 33,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => const RegisterPetPage()));
                  },
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

                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppThemeData.color_black_40)),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(AppStrings.of(context).textButtonHadAccount,),
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
                      style:  Theme.of(context).textTheme.subtitle2,
                    ),
                  ),

                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.of(context).textPolicyProtected,
                      style:  Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
