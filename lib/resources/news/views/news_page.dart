import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/resources/news/views/news_empty_fragment.dart';
import 'package:family_pet/resources/news/views/news_list_data_fragment.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.of(context).textTitleNews,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: StreamBuilder(
        initialData: 1,
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.hasData) {
            return const NewsListDataFragment();
          } else {
            return const NewsEmptyFragment();
          }
        },
      ),
    );
  }
}
