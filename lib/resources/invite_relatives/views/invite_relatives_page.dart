import 'package:auto_size_text/auto_size_text.dart';
import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class InviteRelativePage extends StatelessWidget {
  const InviteRelativePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppStrings.of(context).textInviteRelativesTitle}",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              AutoSizeText(
                "${AppStrings.of(context).textInviteRelativesLabelMain}",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppThemeData.color_black_80),
                maxLines: 1,
              ),
              SizedBox(height: 24),
              Text(
                "Album Chó Top",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 24),
              _itemFirst(),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "${AppStrings.of(context).textInviteRelativesButtonInviteFamily}"),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "${AppStrings.of(context).textInviteRelativesButtonInviteFriend}"),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            AppThemeData.color_black_40),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 130),
              Tooltip(
                message: "Khi được mời với tư cách gia đình. Bạn có thể xem và tải ảnh lên",
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                preferBelow: false,
                verticalOffset: 50,
                decoration: BoxDecoration(
                  color: AppThemeData.color_main,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),

                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 16),
                        Text("${AppStrings.of(context).textInviteRelativesButtonShare}"),
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        AppThemeData.color_black_40),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 16),
                      Text("${AppStrings.of(context).textInviteRelativesButtonCopyUrl}"),
                    ],
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      AppThemeData.color_black_40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemFirst() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: 220,
        height: 220,
        child: Stack(
          children: [
            Image.network(
              "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg",
              fit: BoxFit.fill,
              width: 220,
              height: 220,
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2021",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Tháng 08.2021",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Chó Top",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
