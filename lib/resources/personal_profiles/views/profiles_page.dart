import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/resources/invite_relatives/views/invite_relatives_page.dart';
import 'package:family_pet/resources/list_of_relatives/views/list_relatives_page.dart';
import 'package:family_pet/resources/signup/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).textProfileTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 32,),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://avatarfiles.alphacoders.com/214/thumb-214002.png'),
            ),
            const SizedBox(height: 32,),
            const Text('Chopper',style: TextStyle(fontSize: 22,color: AppThemeData.color_grey_2,fontWeight: FontWeight.w900),),
            const SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppStrings.of(context).textProfileNotLinkAccount,style: const TextStyle(color: AppThemeData.color_warning),),
                const SizedBox(width: 8,),
                const Icon(Icons.warning_amber_outlined,color: AppThemeData.color_warning,),
              ],
            ),
            Container(
              child: ListTile(
                leading: SvgPicture.asset('assets/svgs/svg_footpet.svg'),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileLabelPet,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  'Chó Top',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  '1 năm 7 tháng/ 11.02.2020',
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: ComponentHelper.radius(isSelect: true, size: 16),
              ),
            ),
            const Divider(
              color: AppThemeData.color_black_10,
              height: 0,
              thickness: 1,
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  'Mèo Mun',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  '1 năm 7 tháng/ 11.02.2020',
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: ComponentHelper.radius(
                    backgroundColor: AppThemeData.color_black_40,
                    isSelect: true,
                    size: 16),
              ),
            ),
            const Divider(
              color: AppThemeData.color_black_10,
              height: 0,
              thickness: 1,
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).textProfileButtonAddPet,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              child: ListTile(
                leading: SvgPicture.asset('assets/svgs/svg_friendship.svg'),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileLabelRelatives,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context)=>ListRelativesPage()));
                },
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileListRelatives +
                      '   (30)',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context)=>const InviteRelativePage()));
                },
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).textProfileButtonAddRelatives,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              child: ListTile(
                leading: SvgPicture.asset('assets/svgs/svg_pencil.svg'),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileLabelAccount,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context)=>const SignUpPage()));
                },
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppThemeData.color_main,
                ),
                title: Text(
                  AppStrings.of(context).textProfileButtonAddAccount,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              child: ListTile(
                leading: SvgPicture.asset('assets/svgs/svg_setting.svg'),
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileLabelSettings,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileButtonNotification,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Switch(
                  value: false,
                  onChanged: (bool changeValue) {},
                ),
              ),
            ),
            const Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileButtonChangeLanguages,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            const Divider(
                color: AppThemeData.color_black_10, height: 0, thickness: 1),
            Container(
              color: AppThemeData.color_black_5,
              child: ListTile(
                minLeadingWidth: 0,
                title: Text(
                  AppStrings.of(context).textProfileButtonPolicyAndProtected,
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
