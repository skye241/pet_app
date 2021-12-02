import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/resources/welcome/welcome_cubit.dart';
import 'package:flutter/material.dart';
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
    _animation =
        Tween<double>(begin: 200.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeCubit, WelcomeState>(
      bloc: cubit,
      listener: (BuildContext context, WelcomeState state){
        if (state is WelcomeSuccess){
          Navigator.pushReplacementNamed(context, state.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: AppThemeData.color_main,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/svgs/svg_logo.svg'),
              const SizedBox(
                height: 8.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(-MediaQuery.of(context).size.width * 2),
                  child: Container(
                    width: 5 * MediaQuery.of(context).size.width,
                    child: AnimatedBuilder(
                        animation: _animation,
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: _animationController.value,
                            child: Text(
                              AppStrings.of(context).appName,
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
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
