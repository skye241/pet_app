import 'dart:io';
import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/genaral/librarys/file_storages/file_storage.dart';
import 'package:family_pet/resources/pick_media/blocs/interfaces/i_pick_media_bloc.dart';
import 'package:family_pet/resources/pick_media/blocs/pick_media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class PickMediaPage extends StatefulWidget {
  PickMediaPage({Key? key,this.listFilePick}) : super(key: key);
  Function(List<String>)? listFilePick;

  @override
  _PickMediaPageState createState() => _PickMediaPageState();
}

class _PickMediaPageState extends State<PickMediaPage>
    with TickerProviderStateMixin {
  IPickMediaBloc _iPickMediaBloc = new PickMediaBloc();
  List<File> listFilePick = [];
  late AnimationController _animationIconUp;
  bool _showFullBottomSheet = false;
  Map<String, VideoPlayerController> mapVideoController = new Map();
  double positionStart = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _iPickMediaBloc.loadListMedia();
    _animationIconUp =
        new AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          AppStrings.of(context).TEXT_TITLE_PICK_IMAGE_VIDEO,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: StreamBuilder<Map<int, Map<int, Map<int, List<File>>>>>(
              stream: _iPickMediaBloc.listFileStream,
              builder: (context,
                  AsyncSnapshot<Map<int, Map<int, Map<int, List<File>>>>>
                      snapshot) {
                return snapshot.hasData
                    ? Container(
                        margin: EdgeInsets.only(bottom: 100, top: 40),
                        child: Column(
                          children: snapshot.data!.entries
                              .map((e) => _groupLevel2(e.value, e.key))
                              .toList(),
                        ),
                      )
                    : Center(
                        child: SpinKitSpinningLines(
                            color: AppThemeData.color_main.withOpacity(0.55)));
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: StreamBuilder(
              initialData: _iPickMediaBloc.positionVerticalHide,
              stream: _iPickMediaBloc.positionBottomSheetStream,
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                return Transform(
                  transform: Matrix4.identity()..translate(0.0, snapshot.data!),
                  child: GestureDetector(
                    onVerticalDragStart: (DragStartDetails dragStartDetails) {
                      positionStart = dragStartDetails.globalPosition.dy;
                    },
                    onVerticalDragUpdate:
                        (DragUpdateDetails dragUpdateDetails) {
                      _iPickMediaBloc.updatePotsitionBottomSheet(
                          _iPickMediaBloc.positionOld +
                              (dragUpdateDetails.globalPosition.dy -
                                  positionStart));
                      if (dragUpdateDetails.primaryDelta! >= 0) {
                        _iPickMediaBloc.isShowBottomSheet = false;
                      } else {
                        _iPickMediaBloc.isShowBottomSheet = true;
                      }
                    },
                    onVerticalDragEnd: (DragEndDetails dragEndDetails) {
                      if (_iPickMediaBloc.isShowBottomSheet)
                        _iPickMediaBloc.showBottomSheet();
                      else
                        _iPickMediaBloc.hideBottomSheet();
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 2.0),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                              animation: _animationIconUp,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                      0, (_animationIconUp.value - 1 / 2) * 5),
                                  child: Icon(_iPickMediaBloc.isShowBottomSheet
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up_outlined),
                                );
                              }),
                          _pickPermission(context),
                          SizedBox(
                            height: 24,
                          ),
                          ComponentHelper.textField(
                              hintText: "Mèo Mun",
                              suffix: Icon(Icons.keyboard_arrow_down_sharp)),
                          SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Tiếp tục",
                                style: TextStyle(
                                    color: AppThemeData.color_black_80),
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppThemeData.color_black_40)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mapVideoController.values.forEach((element) {
      element.dispose();
    });
    _animationIconUp.dispose();
    super.dispose();
  }

  Widget _groupLevel2(Map<int, Map<int, List<File>>> map, int year,) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: map.entries
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tháng ${e.key}.$year",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppThemeData.color_black_80),
                        ),
                        ComponentHelper.radius(),
                      ],
                    ),
                    _groupLevel1(e.value, e.key,),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _groupLevel1(Map<int, List<File>> map, int month,{bool isSelect=false}) {
    return Column(
      children: map.entries
          .map((e) => Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " ${e.key} tháng $month",
                          style: TextStyle(fontSize: 16),
                        ),
                        ComponentHelper.radius(),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _itemPickMedia(e.value[index], isSelect);
                      },
                      itemCount: e.value.length,
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _itemPickMedia(File? file, bool isSelect) {
    String typefile = "";
    if (file != null) typefile = "." + file.path.split(".").last;
    Widget element = Container();
    bool isVideo =
        FileStorage.listTypeFileVideo.contains(typefile.toLowerCase());
    if (isVideo) {
      if (mapVideoController[file!.path] == null) {
        mapVideoController[file.path] = new VideoPlayerController.file(file)
          ..initialize().then((value) => setState(() {}));
      }
      element = VideoPlayer(mapVideoController[file.path]!);
    }
    if (FileStorage.listTypeFileImage.contains(typefile.toLowerCase())) {
      element = Image.file(
        file!,
        fit: BoxFit.cover,
        width: double.maxFinite,
        height: double.maxFinite,
      );
    }
    return ComponentHelper.borderRadiusImage(
        image: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: element),
            isVideo
                ? Container(
                    alignment: Alignment.center,
                    color: AppThemeData.color_black_80.withOpacity(0.35),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : Container(),
            Positioned(
                right: 10,
                top: 10,
                child: ComponentHelper.radius(isSelect: isSelect))
          ],
        ),
        borderRadius: 8.0);
  }

  Widget _pickPermission(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _iPickMediaBloc.currentPermissionPickMedia =
                  PermissonPickMedia.family;
            });
          },
          child: Text("Mời gia đình"),
          style: _iPickMediaBloc.currentPermissionPickMedia ==
                  PermissonPickMedia.family
              ? null
              : ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppThemeData.color_black_40),
                ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _iPickMediaBloc.currentPermissionPickMedia =
                  PermissonPickMedia.friend;
            });
          },
          child: Text("Mời bạn bè"),
          style: _iPickMediaBloc.currentPermissionPickMedia ==
                  PermissonPickMedia.friend
              ? null
              : ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppThemeData.color_black_40),
                ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _iPickMediaBloc.currentPermissionPickMedia =
                  PermissonPickMedia.onlyme;
            });
          },
          child: Text("Chỉ mình tôi"),
          style: _iPickMediaBloc.currentPermissionPickMedia ==
              PermissonPickMedia.onlyme
              ? null
              : ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(AppThemeData.color_black_40),
          ),
        ),
      ],
    );
  }
}
