import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/list_of_relatives/list_of_relatives_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListRelativesPage extends StatefulWidget {
  const ListRelativesPage(
      {Key? key, required this.familyMembers, required this.friends})
      : super(key: key);
  final List<UserInfo> familyMembers;
  final List<UserInfo> friends;

  @override
  State<ListRelativesPage> createState() => _ListRelativesPageState();
}

class _ListRelativesPageState extends State<ListRelativesPage>
    with SingleTickerProviderStateMixin {
  // final IListRelativeBloc _iListRelativeBloc = ListRelativesBloc();
  final ListOfRelativesCubit cubit = ListOfRelativesCubit();

  @override
  void initState() {
    print(widget.familyMembers.length.toString() + 'in init');
    cubit.initEvent(widget.familyMembers, widget.friends);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListOfRelativesCubit, ListOfRelativesState>(
        bloc: cubit,
        buildWhen: (ListOfRelativesState prev, ListOfRelativesState current) {
          if (current is ListOfRelativesStateShowLoading) {
            showPopUpLoading(context);
            return false;
          } else if (current is ListOfRelativesStateDismissLoading) {
            Navigator.pop(context);
            return false;
          } else if (current is ListOfRelativesStateShowMessage) {
            showMessage(
                context, AppStrings.of(context).notice, current.message);
            return false;
          } else
            return true;
        },
        builder: (BuildContext context, ListOfRelativesState state) {
          if (state is ListOfRelativesInitial) {
            return _body(context, state);
          } else
            return Container();
        });
  }

  Widget _body(BuildContext context, ListOfRelativesInitial state) {

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, <List<UserInfo>>[state.familyList, state.friendList]);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 133,
            title: Stack(
              children: <Widget>[
                Container(
                  height: 122,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppThemeData.color_black_40, width: 4))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              onPressed: () => Navigator.pop(context, <List<UserInfo>>[state.familyList, state.friendList]),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              )),
                          Expanded(
                            child: Text(
                              AppStrings.of(context).textListRelativesTitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                          ),
                          // Container(
                          //   width: 24,
                          // ),
                        ],
                      ),
                      Container(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          padding: EdgeInsets.zero,
                          // controller: _tabController,
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          labelColor: AppThemeData.color_primary_90,
                          unselectedLabelColor: AppThemeData.color_black_40,
                          indicatorColor: AppThemeData.color_primary_90,
                          indicatorSize: TabBarIndicatorSize.tab,
                          // automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 4,
                          tabs: <Tab>[
                            Tab(
                              text: '${AppStrings.of(context).textTabFamily} (${state.familyList.length})',
                            ),
                            Tab(
                              text: '${AppStrings.of(context).textTabFriend} (${state.friendList.length})',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _listUser(context, state.familyList),
              _listUser(context, state.friendList)
            ],
          ),
        ),
      ),
    );
  }

  Widget _listUser(BuildContext context, List<UserInfo> listUser) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      itemCount: listUser.length,
      itemBuilder: (BuildContext context, int index) {
        final UserInfo user = listUser[index];
        return ListTile(
          leading: user.avatar!.isNotEmpty
              ? CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(Url.baseURLImage +user.avatar!),
                )
              : Image.asset(
                  'assets/images/img_user.png',
                  width: 36,
                  height: 36,
                ),
          title: Text(user.fullName!),
          trailing: GestureDetector(
              onTap: () {
                showMessage(context, AppStrings.of(context).notice,
                    AppStrings.of(context).textListRelativesConfirmDelete,
                    actions: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemeData.color_black_40),
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppStrings.of(context)
                                  .textPopUpCancelButtonDelete)),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.deleteRelation(user);                              },
                              child: Text(AppStrings.of(context)
                                  .textPopUpConfirmButtonDelete)),
                        ),
                      ],
                    ));
              } ,
              child: Text(AppStrings.of(context).delete)),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }
}

// Widget _tabbar(BuildContext context) {
//   return PreferredSize(
//     preferredSize: const Size(double.maxFinite, 80),
//     child: StreamBuilder<EnumRelatives>(
//       initialData: _iListRelativeBloc.indexTab,
//       stream: _iListRelativeBloc.indexRelativesStream,
//       builder: (BuildContext context, AsyncSnapshot<EnumRelatives> snapshot) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: _itemLabelRelatives(
//                   AppStrings
//                       .of(context)
//                       .textListRelativesLabelFamily,
//                   5,
//                   snapshot.data == EnumRelatives.family,
//                   onTap: () {
//                     _iListRelativeBloc.changeIndex(EnumRelatives.family);
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _itemLabelRelatives(
//                   AppStrings
//                       .of(context)
//                       .textListRelativesLabelFriend,
//                   2,
//                   snapshot.data == EnumRelatives.friend,
//                   onTap: () {
//                     _iListRelativeBloc.changeIndex(EnumRelatives.friend);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

// Widget _itemLabelRelatives(String label, int countList, bool isActive,
//     {Function()? onTap}) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       padding: const EdgeInsets.all(15),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border(
//             bottom: BorderSide(
//           color:
//               isActive ? AppThemeData.color_main : AppThemeData.color_black_40,
//           width: 4,
//         )),
//       ),
//       child: Text(
//         '$label ($countList)',
//         style: TextStyle(
//             color: isActive
//                 ? AppThemeData.color_main
//                 : AppThemeData.color_black_40),
//       ),
//     ),
//   );
// }
