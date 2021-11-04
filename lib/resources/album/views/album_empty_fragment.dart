import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class AlbumEmptyFragment extends StatelessWidget {
  const AlbumEmptyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/img_album.png",width: 223,height: 198,),
          SizedBox(height: 16,),
          Text(AppStrings.of(context).textLabelAlbumEmpty,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,height: 1.5,color: AppThemeData.color_black_80),),
          Text(AppStrings.of(context).textSubLabelAlbumEmpty,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,height: 1.5,color: AppThemeData.color_black_80),),
        ],
      ),
    );
  }
}
