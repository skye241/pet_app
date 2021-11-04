import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/resources/add_a_picture/views/add_a_picture_page.dart';
import 'package:flutter/material.dart';

class RegisterPetPage extends StatelessWidget {
  const RegisterPetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 32,
              horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.of(context).textTitleRegisterPet,
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
                        backgroundColor: AppThemeData.color_main,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )),
                    ComponentHelper.itemStep(
                        backgroundColor: AppThemeData.color_neutral_25,
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                  currentStep: 3,
                  colorDone: AppThemeData.color_primary_30,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  colorWait: AppThemeData.color_neutral_25,
                  sizePen: 4),
              SizedBox(
                height: 22,
              ),
              ComponentHelper.textField(hintText: "Tên thú cưng",label: "Tên thú cưng"),
              SizedBox(height: 18,),
              ComponentHelper.textField(hintText: "Album",label: "Album"),
              SizedBox(height: 18,),
              ComponentHelper.textField(hintText: "Giống chó",label: "Giống chó"),
              SizedBox(height: 18,),
              _chooseSexual(context),
              SizedBox(height: 18,),
              ComponentHelper.textField(hintText: "Ngày sinh",label: "Ngày sinh",suffix: Icon(Icons.calendar_today_rounded,color: AppThemeData.color_black_80,size: 20,)),
              SizedBox(height: 18,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddAPicturePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(AppStrings.of(context)
                        .textButtonRegisterAndContinue),
                  )),
              SizedBox(
                height: 20,
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
                    child: Text(AppStrings.of(context).textSkipRegisterPet,),
                  )),
            ],
          ),
        ),
      ),
    );
  }



  Widget _chooseSexual(context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppThemeData.color_black_10),
        borderRadius: BorderRadius.circular(8.0)
      ),
      padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.of(context).textLabelFieldSexual)),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    Text(AppStrings.of(context).textLabelChooseMale),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Radio(value: 0, groupValue: 1, onChanged: (value) {}),
                    Text(AppStrings.of(context).textLabelChooseFemale),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
