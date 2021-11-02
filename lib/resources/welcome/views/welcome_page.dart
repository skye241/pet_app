import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/introduces/views/introduce_page.dart';
import 'package:family_pet/resources/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward().whenComplete((){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TopScreenPage()));
    });
    _animation = Tween(begin: 200.0,end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.color_main,
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svgs/svg_logo.svg"),
            SizedBox(
              height: 8.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Transform(
                transform: Matrix4.identity()..translate(-MediaQuery.of(context).size.width*2),
                child: Container(
                  width: 5*MediaQuery.of(context).size.width,
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animationController.value,
                          child: Text(
                            "Famipet",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                letterSpacing: _animation.value,
                                fontWeight: FontWeight.w700),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
