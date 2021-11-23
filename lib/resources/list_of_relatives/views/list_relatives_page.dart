import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/resources/list_of_relatives/blocs/interfaces/i_list_relatives_bloc.dart';
import 'package:family_pet/resources/list_of_relatives/blocs/list_relatives_bloc.dart';
import 'package:family_pet/resources/list_of_relatives/list_of_relatives_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListRelativesPage extends StatefulWidget {
  ListRelativesPage({Key? key}) : super(key: key);

  @override
  State<ListRelativesPage> createState() => _ListRelativesPageState();
}

class _ListRelativesPageState extends State<ListRelativesPage>
    with SingleTickerProviderStateMixin {
  final IListRelativeBloc _iListRelativeBloc = ListRelativesBloc();
  final ListOfRelativesCubit cubit = ListOfRelativesCubit();

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListOfRelativesCubit, ListOfRelativesState>(
        builder: (BuildContext context, ListOfRelativesState state) {
      return _body(context);
    });
  }

  Widget _body(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppStrings.of(context).textListRelativesTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.maxFinite, 80),
            child: StreamBuilder<EnumRelatives>(
              initialData: _iListRelativeBloc.indexTab,
              stream: _iListRelativeBloc.indexRelativesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<EnumRelatives> snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _itemLabelRelatives(
                          AppStrings.of(context).textListRelativesLabelFamily,
                          5,
                          snapshot.data == EnumRelatives.family,
                          onTap: () {
                            _iListRelativeBloc
                                .changeIndex(EnumRelatives.family);
                          },
                        ),
                      ),
                      Expanded(
                        child: _itemLabelRelatives(
                          AppStrings.of(context).textListRelativesLabelFriend,
                          2,
                          snapshot.data == EnumRelatives.friend,
                          onTap: () {
                            _iListRelativeBloc
                                .changeIndex(EnumRelatives.friend);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: StreamBuilder<List>(
            initialData: _iListRelativeBloc.listUser,
            stream: _iListRelativeBloc.listRelativesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            'https://toigingiuvedep.vn/wp-content/uploads/2021/01/anh-avatar-cho-con-gai-cuc-dep.jpg'),
                      ),
                      title: const Text('Bố'),
                      trailing: Text(AppStrings.of(context).delete),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    );
                  },
                  itemCount: snapshot.data!.length);
            },
          ),
        ),
      ),
    );
  }

  Widget _itemLabelRelatives(String label, int countList, bool isActive,
      {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: isActive
                ? AppThemeData.color_main
                : AppThemeData.color_black_40,
            width: 4,
          )),
        ),
        child: Text(
          '$label ($countList)',
          style: TextStyle(
              color: isActive
                  ? AppThemeData.color_main
                  : AppThemeData.color_black_40),
        ),
      ),
    );
  }
}
