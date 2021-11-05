import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class AlbumListDataFragment extends StatelessWidget {
  const AlbumListDataFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chó Top',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '2021',
              style: TextStyle(
                  color: AppThemeData.color_grey_2,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
            ),
            const SizedBox(
              height: 8,
            ),
            _listTime(),
            const SizedBox(height: 20,),
            _itemFirst(),
          ],
        ),
      ),
    );
  }

  Widget _listTime() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < 100; i++) {
      final DateTime dateTime = DateTime.now().add(Duration(days: i));
      list.add(Text(
        '${dateTime.day} th ${dateTime.month}   ',
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
      children: <Widget>[
        Expanded(
          flex: 39,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg',
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text('2021',style: TextStyle(color: Colors.white,),),
                      Text('Tháng 08.2021',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),),
                      Text('Chó Top',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          flex: 19,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 5,),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg',
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
