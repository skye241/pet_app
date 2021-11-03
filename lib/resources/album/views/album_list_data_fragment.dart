import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class AlbumListDataFragment extends StatelessWidget {
  const AlbumListDataFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chó Top",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2021",
              style: TextStyle(
                  color: AppThemeData.color_grey_2,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
            ),
            SizedBox(
              height: 8,
            ),
            _listTime(),
            SizedBox(height: 20,),
            _itemFirst(),
          ],
        ),
      ),
    );
  }

  Widget _listTime() {
    List<Widget> list = [];
    for (int i = 0; i < 100; i++) {
      DateTime dateTime = DateTime.now().add(Duration(days: i));
      list.add(Text(
        "${dateTime.day} th ${dateTime.month}   ",
        style: TextStyle(
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color:
                i == 0 ? AppThemeData.color_main : AppThemeData.color_black_40),
      ));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget _itemFirst() {
    return Row(
      children: [
        Expanded(
          flex: 39,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: [
                Image.network(
                  "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg",
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2021",style: TextStyle(color: Colors.white,),),
                      Text("Tháng 08.2021",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
                      Text("Chó Top",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 5,),
        Expanded(
          flex: 19,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5,),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}
