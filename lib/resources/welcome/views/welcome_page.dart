import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/resources/welcome/welcome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextStyleTween _styleTween;
  late CurvedAnimation _curvedAnimation;
  final WelcomeCubit cubit = WelcomeCubit();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward().whenComplete(() {
        cubit.initEvent();
      });
    _styleTween = TextStyleTween(
      begin: const TextStyle(
        overflow: TextOverflow.fade,
        color: Colors.white,
          fontSize: 35, letterSpacing: 40, fontWeight: FontWeight.w700),
      end: const TextStyle(
          overflow: TextOverflow.fade,
          color: Colors.white,
          fontSize: 35, letterSpacing: 1, fontWeight: FontWeight.w700),
    );
    _animation =
        Tween<double>(begin:100, end: 1)
            .animate(_animationController);
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeCubit, WelcomeState>(
      bloc: cubit,
      listener: (BuildContext context, WelcomeState state) {
        if (state is WelcomeSuccess) {
          Navigator.pushReplacementNamed(context, state.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: AppThemeData.color_main,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/svgs/svg_logo.svg'),
              const SizedBox(
                height: 8.0,
              ),
              DefaultTextStyleTransition(
                style: _styleTween.animate(_curvedAnimation),
                child: const Text('Famipet', maxLines: 1,),
              ),
              // Transform(
              //   transform: Matrix4.identity()
              //     ..translate(-MediaQuery.of(context).size.width * 2),
              //   child: Container(
              //     width: 5 * MediaQuery.of(context).size.width,
              //     child: AnimatedBuilder(
              //         animation: _animation,
              //         builder: (BuildContext context, Widget? child) {
              //           return Opacity(
              //             // opacity: 1,
              //             opacity: _animationController.value,
              //             child: Text(
              //               'Famipet',
              //               maxLines: 1,
              //               overflow: TextOverflow.fade,
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 35,
              //                   letterSpacing: _animation.value,
              //                   fontWeight: FontWeight.w700),
              //             ),
              //           );
              //         }),
              //   ),
              // ),
              // Transform(
              //   transform: Matrix4.identity()
              //     ..translate(-MediaQuery.of(context).size.width * 2),
              //   child: Container(
              //     width: 5 * MediaQuery.of(context).size.width,
              //     child: AnimatedBuilder(
              //         animation: _animation,
              //         builder: (BuildContext context, Widget? child) {
              //           return Opacity(
              //             opacity: 1,
              //             // opacity: _animationController.value,
              //             child: Text(
              //               'Famipet',
              //               // maxLines: 1,
              //               overflow: TextOverflow.fade,
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 35,
              //                   letterSpacing: _animation.value,
              //                   fontWeight: FontWeight.w700),
              //             ),
              //           );
              //         }),
              //   ),
              // ),
            ],
          ),
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
