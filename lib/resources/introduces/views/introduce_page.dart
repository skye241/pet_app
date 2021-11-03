import 'package:carousel_slider/carousel_slider.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/fast_register_user/views/register_fast_user_page.dart';
import 'package:family_pet/resources/introduces/models/introduce_entity.dart';
import 'package:flutter/material.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  int indexTab = 0;
  List<IntroduceEntity> listIntroduceEntity = [
    new IntroduceEntity(
        title: "Sắp xếp khoa học",
        content:
            "Tự động sắp xếp album theo trình tự thời gian, dễ dàng quan sát ảnh trong album ",
        linkImage: "assets/images/img_introduce_1.png"),
    new IntroduceEntity(
        title: "Dung lượng không giới hạn",
        content:
            "Không giới hạn dung lượng bộ nhớ, lưu trữ ảnh có kích thước lớn",
        linkImage: "assets/images/img_introduce_2.png"),
    new IntroduceEntity(
        title: "Dễ dàng chia sẻ ảnh",
        content: "Miễn phí sử dụng, thỏa thích chia sẻ với gia đình và bạn bè ",
        linkImage: "assets/images/img_introduce_3.png"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 18),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterFastUserPage()));
                      },
                      child: Text(
                        "Bỏ qua",
                        style: TextStyle(color: AppThemeData.color_main),
                      ))),
              SizedBox(
                height: 45,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CarouselSlider(
                          items: listIntroduceEntity.map<Widget>((e) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Image.asset(
                                    e.linkImage!,
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    height: 56,
                                  ),
                                  Text(
                                    e.title!,
                                    style: Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  Text(
                                    e.content!,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  _indexTab(
                                      index: indexTab, total: listIntroduceEntity.length),
                                  SizedBox(
                                    height: 58,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(vertical: 15.0),
                                        alignment: Alignment.center,
                                        child: Text("Tiếp"),
                                      )),
                                ],
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                              onPageChanged: (int index,
                                  CarouselPageChangedReason
                                      carouselPageChangeReason) {
                                setState(() {
                                  indexTab = index;
                                });
                              },
                              aspectRatio: 2.0,
                              enlargeCenterPage: false,
                              initialPage: 0,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              height: double.maxFinite)),
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

  Widget _indexTab({int index = 0, int total = 1}) {
    int indexTab = 0;
    List<Widget> list = [];

    if (index < total || index > 0) {
      indexTab = index;
    }
    for (int i = 0; i < total; i++) {
      list.add(_circlePage(isEnable: i == indexTab));
      if (i >= 0 && i < total - 1) {
        list.add(SizedBox(
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

  Widget _circlePage({bool isEnable = false}) {
    return CircleAvatar(
      radius: 4,
      backgroundColor: isEnable ? AppThemeData.color_main : Color(0xffaaaaaa),
    );
  }
}
