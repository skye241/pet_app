import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:family_pet/genaral/librarys/file_storages/file_storage.dart';
import 'package:family_pet/resources/pick_media/blocs/interfaces/i_pick_media_bloc.dart';
import 'package:family_pet/resources/pick_media/blocs/pick_media_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class PickMediaPage extends StatefulWidget {
  const PickMediaPage({Key? key, this.onChangePicker}) : super(key: key);
  final Function(Set<File>,PermissonPickMedia)? onChangePicker;

  @override
  _PickMediaPageState createState() => _PickMediaPageState();
}

class _PickMediaPageState extends State<PickMediaPage>
    with TickerProviderStateMixin {
  final IPickMediaBloc _iPickMediaBloc =  PickMediaBloc();
  late AnimationController _animationIconUp;
  final bool _showFullBottomSheet = false;
  Map<String, VideoPlayerController> mapVideoController = <String, VideoPlayerController>{};
  double positionStart = 0;
  final Map<dynamic, bool> _pickMediaRadio =  <dynamic, bool>{};

  @override
  void initState() {
    super.initState();
    _animationIconUp =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    Future<dynamic>.delayed(const Duration(seconds: 1)).whenComplete(() => _iPickMediaBloc.loadListMedia());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          AppStrings.of(context).textPickMediaTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: StreamBuilder<Map<int, Map<int, Map<int, List<File>>>>>(
              stream: _iPickMediaBloc.listFileStream,
              builder: (BuildContext context,
                  AsyncSnapshot<Map<int, Map<int, Map<int, List<File>>>>>
                      snapshot) {
                return snapshot.hasData
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 100, top: 40),
                        child: Column(
                          children: snapshot.data!.entries
                              .map((MapEntry<int, Map<int, Map<int, List<File>>>> e) => _groupLevel2(e.value, e.key))
                              .toList(),
                        ),
                      )
                    : Container(
                  height: MediaQuery.of(context).size.height-AppBar().preferredSize.height-200,
                        alignment: Alignment.center,
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
                      _iPickMediaBloc.updatePositionBottomSheet(
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
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.grey, blurRadius: 2.0),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AnimatedBuilder(
                              animation: _animationIconUp,
                              builder: (BuildContext context, Widget? child) {
                                return Transform.translate(
                                  offset: Offset(
                                      0, (_animationIconUp.value - 1 / 2) * 5),
                                  child: Icon(_iPickMediaBloc.isShowBottomSheet
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up_outlined),
                                );
                              }),
                          _pickPermission(context),
                          const SizedBox(
                            height: 24,
                          ),
                          // ComponentHelper.textField(
                          //     hintText: "Mèo Mun",
                          //     suffix: Icon(Icons.keyboard_arrow_down_sharp)),
                          // SizedBox(
                          //   height: 24,
                          // ),
                          ElevatedButton(
                            onPressed: () {
                              if(widget.onChangePicker!=null){
                                widget.onChangePicker!(_iPickMediaBloc.listPick,_iPickMediaBloc.currentPermissionPickMedia);
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                AppStrings.of(context).textPickMediaContinue,
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppThemeData.color_main)),
                          ),
                          const SizedBox(
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
    for (final VideoPlayerController element in mapVideoController.values) {
      element.dispose();
    }
    _animationIconUp.dispose();
    super.dispose();
  }

  Widget _groupLevel2(
    Map<int, Map<int, List<File>>> map,
    int year,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Column(
        children: map.entries.map((MapEntry<int, Map<int, List<File>>> e) {
          //Để các radio nhóm ảnh theo tháng thành false nếu nó đang không có giá trị
          if (_pickMediaRadio['${e.key}$year'] == null)
            _pickMediaRadio['${e.key}$year'] = false;

          // Khởi tạo giá trị mặc định bằng true khi  click tất cả thì hiển thị radio đã click tất
          _pickMediaRadio['${e.key}$year'] = true;
          e.value.forEach((int key, List<File> value) {
            // Khởi tạo giá trị mặc định bằng true
            _pickMediaRadio['$key${e.key}$year'] = true;
            for (final File element in value) {
              if ((_pickMediaRadio[element.path] ?? false) == false) {
                _pickMediaRadio['$key${e.key}$year'] = false;
              }
            }
            if ((_pickMediaRadio['$key${e.key}$year'] ?? false) == false) {
              _pickMediaRadio['${e.key}$year'] = false;
            }
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${AppStrings.of(context).textPickMediaLabelMonth} ${e.key}.$year',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppThemeData.color_black_80),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _pickMediaRadio['${e.key}$year'] =
                              !(_pickMediaRadio['${e.key}$year'] ?? false);
                          if (_pickMediaRadio['${e.key}$year']!) {
                            // Pick theo năm toàn bộ radio theo tháng và từng item đều true
                            e.value.forEach((int key, List<File> value) {
                              _pickMediaRadio['$key${e.key}$year'] =
                                  true; //map[Ngàythángnăm]
                              for (final File element in value) {
                                // Các radio từng file được chuyển trạng thái sang true
                                _pickMediaRadio[element.path] = true;
                                // Các file được thêm vào list pick
                                _iPickMediaBloc.listPick.add(element);
                              }
                            });
                          } else {
                            //Hủy Pick theo năm toàn bộ radio theo tháng và từng item đều false
                            e.value.forEach((int key, List<File> value) {
                              _pickMediaRadio['$key${e.key}$year'] =
                                  false; //map[Ngàythángnăm]
                              for (final File element in value) {
                                // Các radio từng file được chuyển trạng thái sang false
                                _pickMediaRadio[element.path] = false;
                                // Các file được xóa khỏi list pick
                                _iPickMediaBloc.listPick.remove(element);
                              }
                            });
                          }
                        });
                      },
                      child: ComponentHelper.radius(
                          isSelect: _pickMediaRadio['${e.key}$year'])),
                ],
              ),
              _groupLevel1(e.value, e.key, year),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _groupLevel1(Map<int, List<File>> map, int month, int year) {
    return Column(
      children: map.entries.map((MapEntry<int, List<File>> e) {
        if (_pickMediaRadio['${e.key}$month$year'] == null)
          _pickMediaRadio['${e.key}$month$year'] = false;
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${e.key} ${AppStrings.of(context).textPickMediaLabelMonth.toLowerCase()} $month',
                    style: const TextStyle(fontSize: 16),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _pickMediaRadio['${e.key}$month$year'] =
                              !(_pickMediaRadio['${e.key}$month$year'] ??
                                  false);
                          if (_pickMediaRadio['${e.key}$month$year']!) {
                            for (final File element in e.value) {
                              _pickMediaRadio[element.path] = true;
                              _iPickMediaBloc.listPick.add(element);
                            }
                          } else {
                            for (final File element in e.value) {
                              _pickMediaRadio[element.path] = false;
                              _iPickMediaBloc.listPick.remove(element);
                            }
                          }
                        });
                      },
                      child: ComponentHelper.radius(
                          isSelect: _pickMediaRadio['${e.key}$month$year'])),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _itemPickMedia(e.value[index], year, month, e.key);
                },
                itemCount: e.value.length,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _itemPickMedia(File? file, int year, int mounth, int day) {
    if (_pickMediaRadio[file?.path] == null) {
      _pickMediaRadio[file?.path] = false;
    }
    String typefile = '';
    if (file != null) {
      typefile = '.' + file.path.split('.').last;
    }
    Widget element = Container();
    final bool isVideo =
        FileStorage.listTypeFileVideo.contains(typefile.toLowerCase());
    if (isVideo) {
      if (mapVideoController[file!.path] == null) {
        mapVideoController[file.path] = VideoPlayerController.file(file)
          ..initialize().then((dynamic value) => setState(() {}));
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
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: element),
            if (isVideo)
              Container(
                    alignment: Alignment.center,
                    color: AppThemeData.color_black_80.withOpacity(0.35),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ) else Container(),
            Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        _pickMediaRadio[file?.path] =
                            !(_pickMediaRadio[file?.path] ?? false);
                        if (_pickMediaRadio[file?.path]!) {
                          //Thêm file vào pick
                          _iPickMediaBloc.listPick.add(file!);
                        } else {
                          // Loại bỏ file khỏi list pick
                          _iPickMediaBloc.listPick.remove(file);
                          _pickMediaRadio['$day$mounth$year'] = false;
                          _pickMediaRadio['$mounth$year'] = false;
                        }
                      });
                    },
                    child: ComponentHelper.radius(
                        isSelect: _pickMediaRadio[file?.path])))
          ],
        ),
        borderRadius: 8.0);
  }

  Widget _pickPermission(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _iPickMediaBloc.currentPermissionPickMedia =
                    PermissonPickMedia.family;
              });
            },
            child: AutoSizeText(AppStrings.of(context).textPickMediaButtonFamily,maxLines: 1,),
            style: _iPickMediaBloc.currentPermissionPickMedia ==
                    PermissonPickMedia.family
                ? null
                : ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppThemeData.color_black_40),
                  ),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _iPickMediaBloc.currentPermissionPickMedia =
                    PermissonPickMedia.friend;
              });
            },
            child: AutoSizeText(AppStrings.of(context).textPickMediaButtonFriend,maxLines: 1,),
            style: _iPickMediaBloc.currentPermissionPickMedia ==
                    PermissonPickMedia.friend
                ? null
                : ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppThemeData.color_black_40),
                  ),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _iPickMediaBloc.currentPermissionPickMedia =
                    PermissonPickMedia.onlyme;
              });
            },
            child: AutoSizeText(AppStrings.of(context).textPickMediaButtonOnlyMe,maxLines: 1,),
            style: _iPickMediaBloc.currentPermissionPickMedia ==
                    PermissonPickMedia.onlyme
                ? null
                : ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppThemeData.color_black_40),
                  ),
          ),
        ),
      ],
    );
  }
}
