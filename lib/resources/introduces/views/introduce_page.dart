import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/resources/introduces/models/introduce_entity.dart';
import 'package:flutter/material.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  final PageController _pageController = PageController();

  int indexTab = 0;
  final List<IntroduceEntity> listIntroduceEntity = <IntroduceEntity>[];

  @override
  void didChangeDependencies() {
    listIntroduceEntity.addAll(<IntroduceEntity>[
      IntroduceEntity(
          id: 0,
          title: AppStrings.of(context).firstPageTitle,
          content: AppStrings.of(context).firstPageContent,
          linkImage: 'assets/images/img_introduce_1.png'),
      IntroduceEntity(
          id: 1,
          title: AppStrings.of(context).secondPageTitle,
          content: AppStrings.of(context).secondPageContent,
          linkImage: 'assets/images/img_introduce_2.png'),
      IntroduceEntity(
          id: 2,
          title: AppStrings.of(context).thirdPageTitle,
          content: AppStrings.of(context).thirdPageContent,
          linkImage: 'assets/images/img_introduce_3.png'),
    ]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(right: 18),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.registerFastUserPage);
                      },
                      child: const Text(
                        'Bỏ qua',
                        style: TextStyle(color: AppThemeData.color_main),
                      ))),
              const SizedBox(
                height: 45,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: listIntroduceEntity
                            .map((IntroduceEntity e) => page(e))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget page(IntroduceEntity e) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: <Widget>[
          Image.asset(
            e.linkImage!,
            width: 250,
            height: 250,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 56,
          ),
          Text(
            e.title!,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Text(
            e.content!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          _indexTab(index: e.id!, total: listIntroduceEntity.length),
          const SizedBox(
            height: 58,
          ),
          ElevatedButton(
              onPressed: () => e.id! < listIntroduceEntity.length - 1
                  ? animateToPage(e.id! + 1)
                  : Navigator.pushReplacementNamed(
                      context, RoutesName.registerFastUserPage),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                alignment: Alignment.center,
                child: const Text('Tiếp tục'),
              )),
        ]));
  }

  Widget _indexTab({int index = 0, int total = 1}) {
    int indexTab = 0;
    final List<Widget> list = <Widget>[];

    if (index < total || index > 0) {
      indexTab = index;
    }
    for (int i = 0; i < total; i++) {
      list.add(_circlePage(isEnable: i == indexTab));
      if (i >= 0 && i < total - 1) {
        list.add(const SizedBox(
          width: 8,
        ));
      }
    }
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    ));
  }

  void animateToPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Widget _circlePage({bool isEnable = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isEnable ? AppThemeData.color_main : AppThemeData.color_black_40,
        shape: BoxShape.circle,
      ),
    );
  }
}
