import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/language/language_cubit.dart';
import 'package:family_pet/resources/personal_profiles/profiles_page_cubit.dart';
import 'package:family_pet/resources/top_page/cubit/top_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({Key? key}) : super(key: key);

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final ProfilesPageCubit cubit = ProfilesPageCubit();

  @override
  void initState() {
    cubit.initEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppStrings.of(context).textProfileTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: BlocBuilder<ProfilesPageCubit, ProfilesPageState>(
          bloc: cubit,
          builder: (BuildContext context, ProfilesPageState state) {
            if (state is ProfilesPageStateLoaded) {
              return _body(context, state);
            } else if (state is ProfilesPageInitial) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppThemeData.color_primary_90),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget _body(BuildContext context, ProfilesPageStateLoaded state) {
    return CustomScrollView(slivers: <SliverList>[
      _avatarAndName(context, state),
      _petList(context, state),
      _other(context, state)
    ]);
  }

  SliverList _avatarAndName(
      BuildContext context, ProfilesPageStateLoaded state) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      Container(
        height: 32,
      ),
      Container(
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppThemeData.color_black_10,
          image: state.user.avatar!.isNotEmpty
              ? DecorationImage(image: NetworkImage(Url.baseURLImage + state.user.avatar!))
              : const DecorationImage(
                  image: AssetImage('assets/images/img_user.png')),
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      Center(
        child: Text(
          state.user.fullName!,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            accountStatus(context, state.user.status!),
            style: TextStyle(
                color: state.user.status != AccountStatus.active
                    ? AppThemeData.color_warning
                    : AppThemeData.color_black_80),
          ),
          const SizedBox(
            width: 8,
          ),
          if (state.user.status != AccountStatus.active)
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
        child: ListTile(
          leading: SvgPicture.asset('assets/svgs/svg_footpet.svg'),
          minLeadingWidth: 0,
          title: Text(
            AppStrings.of(context).textProfileLabelPet,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      )
    ]));
  }

  SliverList _petList(BuildContext context, ProfilesPageStateLoaded state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              petTile(context, state.listPets[index]),
          childCount: state.listPets.length),
    );
  }

  SliverList _other(BuildContext context, ProfilesPageStateLoaded state) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        const Divider(
          color: AppThemeData.color_black_10,
          height: 0,
          thickness: 1,
        ),
        Container(
          color: AppThemeData.color_black_5,
          child: ListTile(
            onTap: () async {
              final dynamic object = await Navigator.pushNamed(
                  context, RoutesName.registerPet,
                  arguments: <String, dynamic>{Constant.isFirstStep: false});
              if (object != null) {
                cubit.addPet(object as Pet);
              }
            },
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
            onTap: () {
              Navigator.pushNamed(context, RoutesName.listRelativesPage,
                  arguments: <String, dynamic>{
                    Constant.friends: state.friendList,
                    Constant.familyMembers: state.familyList
                  });
            },
            minLeadingWidth: 0,
            title: Text(
              AppStrings.of(context).textProfileListRelatives +
                  ' (${state.familyList.length + state.friendList.length})',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        const Divider(
            color: AppThemeData.color_black_10, height: 0, thickness: 1),
        Container(
          color: AppThemeData.color_black_5,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesName.inviteRelativesPage,
              );
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
            onTap: () {
              Navigator.pushNamed(context, RoutesName.signUpPage,
                  arguments: <String, dynamic>{Constant.userInfo: state.user});
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
            onTap: () {
              BlocProvider.of<LanguageCubit>(context).changeLocale(
                  prefs!.getString(Constant.language) == 'vi' ? 'ja' : 'vi');
              BlocProvider.of<TopScreenCubit>(context).reload();
            },
            minLeadingWidth: 0,
            title: Text(
              AppStrings.of(context).textProfileButtonChangeLanguages,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        const Divider(
            color: AppThemeData.color_black_10, height: 0, thickness: 1),
        ListTile(
          onTap: () => Navigator.pushNamed(context, RoutesName.termPage,
              arguments: <String, dynamic>{
                Constant.termType: TermType.securityTerm,
              }),
          tileColor: AppThemeData.color_black_5,
          minLeadingWidth: 0,
          title: Text(
            AppStrings.of(context).textProfileButtonPolicyAndProtected,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ]),
    );
  }

  Widget petTile(BuildContext context, Pet pet) {
    Duration age = Duration.zero;
    int year = 0;
    int month = 0;
    if (pet.birthdate!.isNotEmpty) {
      age = DateTime.now().difference(DateTime.parse(pet.birthdate!));
      year = (age.inDays / 365).floor();
      month = ((age.inDays - year * 365) / 30).round();
    }

    return ListTile(
      tileColor: AppThemeData.color_black_5,
      minLeadingWidth: 0,
      title: Text(
        pet.name!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: pet.birthdate!.isNotEmpty
          ? Text(
              '$year ${AppStrings.of(context).year} $month ${AppStrings.of(context).month}/ ${pet.birthdate}',
              style: Theme.of(context).textTheme.headline5,
            )
          : null,
      trailing: ComponentHelper.radius(isSelect: true, size: 16),
    );
  }

  String accountStatus (BuildContext context, String status){
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
}
