import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).TEXT_PROFILE_TITLE,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://avatarfiles.alphacoders.com/214/thumb-214002.png"),
            ),
            SizedBox(height: 32,),
            Text("Chopper",style: TextStyle(fontSize: 22,color: AppThemeData.color_grey_2,fontWeight: FontWeight.w900),),
            SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.of(context).TEXT_PROFILE_NOT_LINK_ACCOUNT,style: TextStyle(color: AppThemeData.color_warning),),
                SizedBox(width: 8,),
                Icon(Icons.warning_amber_outlined,color: AppThemeData.color_warning,),
              ],
            ),
            Container(
              child: ListTile(
                leading: SvgPicture.asset("assets/svgs/svg_footpet.svg"),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_LABEL_PET,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  "Chó Top",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "1 năm 7 tháng/ 11.02.2020",
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: ComponentHelper.radius(isSelect: true, size: 16),
              ),
            ),
            Divider(
              color: AppThemeData.color_black_10,
              height: 0,
              thickness: 1,
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  "Mèo Mun",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "1 năm 7 tháng/ 11.02.2020",
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: ComponentHelper.radius(
                    backgroundColor: AppThemeData.color_black_40,
                    isSelect: true,
                    size: 16),
              ),
            ),
            Divider(
              color: AppThemeData.color_black_10,
              height: 0,
              thickness: 1,
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                leading: Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_ADD_PET,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              child: ListTile(
                leading: SvgPicture.asset("assets/svgs/svg_friendship.svg"),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_LABEL_RELATIVES,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_ADD_RELATIVES +
                      "   (30)",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                leading: Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_ADD_RELATIVES,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              child: ListTile(
                leading: SvgPicture.asset("assets/svgs/svg_pencil.svg"),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_LABEL_ACCOUNT,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                leading: Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_ADD_ACCOUNT,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              child: ListTile(
                leading: SvgPicture.asset("assets/svgs/svg_setting.svg"),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_LABEL_SETTINGS,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_NOTIFICATION,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Switch(
                  value: false,
                  onChanged: (changeValue) {},
                ),
              ),
            ),
            Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_CHANGE_LANGUAGES,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).TEXT_PROFILE_BUTTON_POLICY_AND_PROTECTED,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
