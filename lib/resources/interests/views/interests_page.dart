import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestsPage extends StatelessWidget {
  const InterestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).textTitleInterests,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return _itemGridView();
          },
        ),
      ),
    );
  }

  Widget _itemGridView() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
              image: NetworkImage(
                "https://static01.nyt.com/images/2019/06/17/science/17DOGS/17DOGS-mobileMasterAt3x-v2.jpg",
              ),
              fit: BoxFit.cover
            ),
          ),
        ),
        Positioned(
          child: Row(
            children: [
              SvgPicture.asset("assets/svgs/svg_message.svg"),
              SizedBox(width: 2,),
              Text("10",style: TextStyle(fontSize: 12,color: Colors.white),)
            ],
          ),
          bottom: 8,
          left: 8,
        ),
        Positioned(
          child: SvgPicture.asset("assets/svgs/svg_heart.svg"),
          bottom: 8,
          right: 8,
        ),
      ],
    );
  }
}
