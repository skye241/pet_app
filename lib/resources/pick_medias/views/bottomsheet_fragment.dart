import 'package:flutter/material.dart';

class BottomSheetFragment extends StatefulWidget {
  const BottomSheetFragment({Key? key}) : super(key: key);

  @override
  _BottomSheetFragmentState createState() => _BottomSheetFragmentState();
}

class _BottomSheetFragmentState extends State<BottomSheetFragment> {
  double positionStart = 0.0,positionUpdate = 0.0,positionEnd = 0.0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details){
        positionStart = details.localPosition.dy;
      },
      onVerticalDragUpdate: (details){
        positionUpdate =  details.localPosition.dy - positionStart;
        setState(() {

        });
      },
      onVerticalDragEnd: (details){
        positionEnd = details.velocity.pixelsPerSecond.dy;
      },
      child: Transform(
        transform:  Matrix4.identity()..translate(0.0,positionUpdate-positionEnd),
        child: Container(
          width: double.maxFinite,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("321"),
              Text("321"),
              Text("321"),
              Text("321"),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
