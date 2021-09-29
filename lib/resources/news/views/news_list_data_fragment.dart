import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class NewsListDataFragment extends StatelessWidget {
  const NewsListDataFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return _itemNews();
        },
        separatorBuilder: (context, snapshot) {
          return Divider(
            indent: 20,
            endIndent: 20,
            height: 22,
          );
        },
        itemCount: 3,
      ),
    );
  }

  Widget _itemNews() {
    return Container(
      height: 110,
      child: Row(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://thumbs-prod.si-cdn.com/ej9KRK9frB5AXD6W9LXKFnuRc-0=/fit-in/1600x0/https://public-media.si-cdn.com/filer/ad/7b/ad7b3860-ad5f-43dc-800e-af57830cd1d3/labrador.jpg"),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Album chó",
                        style: TextStyle(
                            color: AppThemeData.color_black_60,
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Mẹ ",
                              style: TextStyle(
                                  color: AppThemeData.color_black_80,
                                  fontSize: 18,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "Dễ thương quá!",
                              style: TextStyle(
                                  color: AppThemeData.color_black_80,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Text(
                  "9 phút trước",
                  style: TextStyle(
                      color: AppThemeData.color_grey_3,
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
