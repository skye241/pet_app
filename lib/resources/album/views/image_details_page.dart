import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Chó Top',
                style: Theme.of(context).appBarTheme.titleTextStyle),
            const Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                ComponentHelper.borderRadiusImage(
                  image: Image.network(
                    'https://wallpaperaccess.com/full/1625242.jpg',
                  ),
                  borderRadius: 8.0,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Icon(Icons.message),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('20'),
                    const SizedBox(
                      width: 18,
                    ),
                    SvgPicture.asset('assets/svgs/svg_heart.svg'),
                  ],
                ),
                const SizedBox(height: 27),
                ComponentHelper.textField(
                  suffix: Text(
                    '\n Gửi',
                    style: TextStyle(color: Colors.green.withOpacity(0.55)),
                  ),
                  hintText: 'Viết comment',
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _itemComment(
                      context,
                      linkImage:
                          'https://toppng.com/uploads/preview/cool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png',
                      commentUser: 'Ông nội nhà mình hầm hố ghê',
                      nameUser: 'Mèo Cụ',
                    );
                  },
                  itemCount: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemComment(
    BuildContext context, {
    String? linkImage,
    String? nameUser,
    String? commentUser,
  }) {
    final String link = linkImage ??
        'https://toppng.com/uploads/preview/cool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png';
    final String name = "${nameUser ?? ""} ";
    final String comment = commentUser ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(link),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: RichText(
                      text: TextSpan(
                          text: name,
                          style: Theme.of(context).textTheme.headline3,
                          children: <TextSpan>[
                            TextSpan(
                                text: comment,
                                style: Theme.of(context).textTheme.bodyText2),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(
                'Xoá',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
