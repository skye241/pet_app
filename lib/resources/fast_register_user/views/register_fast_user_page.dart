import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/resources/register_pet/views/register_pet_page.dart';
import 'package:flutter/material.dart';

class RegisterFastUserPage extends StatefulWidget {
  RegisterFastUserPage({Key? key}) : super(key: key);

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
            children: [
              Text(
                AppStrings.of(context).TEXT_TITLE_REGISTER_USER,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 40,
              ),
              ComponentHelper.stepByStepHorizontal(
                  children: [
                    ComponentHelper.itemStep(
                        backgroundColor: AppThemeData.color_main,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )),
                    ComponentHelper.itemStep(
                        backgroundColor: AppThemeData.color_neutral_25,
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white),
                        )),
                    ComponentHelper.itemStep(
                        backgroundColor: AppThemeData.color_neutral_25,
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                  currentStep: 2,
                  colorDone: AppThemeData.color_primary_30,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  colorWait: AppThemeData.color_neutral_25,
                  sizePen: 4),
              SizedBox(
                height: 22,
              ),
              Image(
                image: AssetImage(
                    "assets/images/img_register_1.png",),
                width: 289,
                height: 226,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: AppStrings.of(context).TEXT_LABEL_FIELD_NAME_USER,
                        style: Theme.of(context).textTheme.bodyText2),
                    TextSpan(
                        text: AppStrings.of(context)
                            .TEXT_SUB_LABEL_FIELD_NAME_USER,
                        style: Theme.of(context).textTheme.subtitle2),
                  ]),
                ),
              ),
              SizedBox(height: 18,),
              Form(
                child: ComponentHelper.textField(hintText: AppStrings.of(context).TEXT_LABEL_FIELD_NAME_USER),
              ),
              SizedBox(
                height: 33,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPetPage()));
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(AppStrings.of(context).TEXT_BUTTON_CONTINUE),
                  )),
              SizedBox(
                height: 18,
              ),
              ElevatedButton(

                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppThemeData.color_black_40)),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(AppStrings.of(context).TEXT_BUTTON_HAD_ACCOUNT,),
                  )),

              SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.of(context).TEXT_RULE_SERVICE,
                      style:  Theme.of(context).textTheme.subtitle2,
                    ),
                  ),

                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.of(context).TEXT_POLICY_PROTECTED,
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
