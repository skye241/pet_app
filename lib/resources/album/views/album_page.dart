import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/album/views/album_empty_fragment.dart';
import 'package:family_pet/resources/album/views/album_list_data_fragment.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlbumListDataFragment(),
    );
  }
}
