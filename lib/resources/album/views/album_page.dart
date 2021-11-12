import 'package:family_pet/resources/album/album_cubit.dart';
import 'package:family_pet/resources/album/views/album_list_data_fragment.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final AlbumCubit cubit = AlbumCubit();

  @override
  void initState() {
    cubit.getAlbum();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AlbumListDataFragment(),
    );
  }
}
