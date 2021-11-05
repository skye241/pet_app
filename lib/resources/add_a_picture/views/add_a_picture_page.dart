import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/resources/top_screen.dart';
import 'package:flutter/material.dart';

class AddAPicturePage extends StatelessWidget {
  const AddAPicturePage({Key? key}) : super(key: key);

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
              Image.asset(
                  'assets/images/img_album.png',width: 198,height: 198,),
              const SizedBox(
                height: 126,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (BuildContext context)=>TopScreenPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                        AppStrings.of(context).textButtonChooseAPicture),
                  )),
              const SizedBox(
                height: 10,
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
                    child: Text(AppStrings.of(context).textButtonSkipChooseAPicture,),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
