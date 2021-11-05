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
        padding: const EdgeInsets.all(19),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _itemGridView();
          },
        ),
      ),
    );
  }

  Widget _itemGridView() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
              image: NetworkImage(
                'https://static01.nyt.com/images/2019/06/17/science/17DOGS/17DOGS-mobileMasterAt3x-v2.jpg',
              ),
              fit: BoxFit.cover
            ),
          ),
        ),
        Positioned(
          child: Row(
            children: <Widget>[
              SvgPicture.asset('assets/svgs/svg_message.svg'),
              const SizedBox(width: 2,),
              const Text('10',style: TextStyle(fontSize: 12,color: Colors.white),)
            ],
          ),
          bottom: 8,
          left: 8,
        ),
        Positioned(
          child: SvgPicture.asset('assets/svgs/svg_heart.svg'),
          bottom: 8,
          right: 8,
        ),
      ],
    );
  }
}
