import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/list_of_relatives/blocs/interfaces/i_list_relatives_bloc.dart';
import 'package:family_pet/resources/list_of_relatives/blocs/list_relatives_bloc.dart';
import 'package:flutter/material.dart';

class ListRelativesPage extends StatelessWidget {
  ListRelativesPage({Key? key}) : super(key: key);
  IListRelativeBloc _iListRelativeBloc = new ListRelativesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "${AppStrings.of(context).TEXT_LISTRELATIVES_TITLE}",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 80),
          child: StreamBuilder<EnumRelatives>(
            initialData: _iListRelativeBloc.indexTab,
            stream: _iListRelativeBloc.indexRelativesStream,
            builder: (context, AsyncSnapshot<EnumRelatives> snapshot) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _itemLabelRelatives(
                        "${AppStrings.of(context).TEXT_LISTRELATIVES_LABEL_FAMILY}",
                        5,
                        snapshot.data == EnumRelatives.family,
                        onTap: () {
                          _iListRelativeBloc.changeIndex(EnumRelatives.family);
                        },
                      ),
                    ),
                    Expanded(
                      child: _itemLabelRelatives(
                        "${AppStrings.of(context).TEXT_LISTRELATIVES_LABEL_FRIEND}",
                        2,
                        snapshot.data == EnumRelatives.friend,
                        onTap: () {
                          _iListRelativeBloc.changeIndex(EnumRelatives.friend);
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
        padding: EdgeInsets.only(top: 32),
        child: StreamBuilder<List>(
          initialData: _iListRelativeBloc.listUser,
          stream: _iListRelativeBloc.listRelativesStream,
          builder: (context, AsyncSnapshot<List> snapshot) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                          "https://toigingiuvedep.vn/wp-content/uploads/2021/01/anh-avatar-cho-con-gai-cuc-dep.jpg"),
                    ),
                    title: Text("Bố"),
                    trailing: Text("Xóa"),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  );
                },
                itemCount: snapshot.data!.length);
          },
        ),
      ),
    );
  }

  Widget _itemLabelRelatives(String label, int countList, bool isActive,
      {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
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
          "${label} (${countList})",
          style: TextStyle(
              color: isActive
                  ? AppThemeData.color_main
                  : AppThemeData.color_black_40),
        ),
      ),
    );
  }
}
