import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/resources/news/news_cubit.dart';
import 'package:family_pet/resources/news/views/news_empty_fragment.dart';
import 'package:family_pet/resources/news/views/news_list_data_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsCubit cubit = NewsCubit();

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
            AppStrings.of(context).textTitleNews,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: BlocProvider<NewsCubit>(
          create: (BuildContext context) => cubit,
          child: BlocBuilder<NewsCubit, NewsState>(
            builder: (BuildContext context, NewsState state) {
              if (state is NewsStateLoaded) {
                if (state.listComment.isEmpty) {
                  return const NewsEmptyFragment();
                } else
                  return NewsListDataFragment(
                    listNotification: state.listComment,
                  );
              } else
                return Container();
            },
          ),
        ));
  }
}
