import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/resources/signup/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpCubit cubit = SignUpCubit();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        bloc: cubit,
        child: BlocBuilder<SignUpCubit, SignUpState>(
          bloc: cubit,
          buildWhen: (SignUpState prev, SignUpState current) {
            if (current is! SignUpInitial) {
              return false;
            } else
              return true;
          },
          builder: (BuildContext context, SignUpState state) {
            if (state is SignUpInitial) {
              return _body(context, state);
            } else
              return Container();
          },
        ),
        listener: (BuildContext context, SignUpState state) {
          if (state is SignUpShowPopUpLoading) {
            showPopUpLoading(context);
          } else if (state is SignUpDismissPopUpLoading) {
            Navigator.pop(context);
          } else if (state is SignUpSuccess) {
          } else if (state is SignUpFail) {}
        });
  }

  Widget _body(BuildContext context, SignUpInitial state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              AppStrings.of(context).textSignUpTitle,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 68.0, vertical: 62.0),
                    child: Image.asset('assets/images/img_register_2.png'),
                  ),
                  ComponentHelper.textField(
                    focusNode: emailNode,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null && value!.isEmpty) {
                        return 'Vui lòng nhập email';
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return 'Vui lòng nhập email đúng định dạng';
                      } else
                        return null;
                    },
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(passwordNode),
                    textInputAction: TextInputAction.next,
                    hintText: AppStrings.of(context).textSignUpLabelEmail,
                    label: AppStrings.of(context).textSignUpLabelEmail,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  ComponentHelper.textField(
                      focusNode: passwordNode,
                      obscureText: state.showPassword,
                      controller: passwordController,
                      hintText: AppStrings.of(context).textSignUpLabelPassword,
                      label: AppStrings.of(context).textSignUpLabelPassword,
                      suffix: IconButton(
                          onPressed: () =>
                              cubit.showPassword(state.showPassword),
                          icon: Icon(
                            state.showPassword
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            color: AppThemeData.color_black_80,
                          ))),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: _eventSignUp,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 11.54),
                      width: double.maxFinite,
                      child:
                          Text(AppStrings.of(context).textSignUpButtonSignUp),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      const Expanded(
                          child: Divider(
                        color: Colors.black,
                        endIndent: 15,
                      )),
                      Text(AppStrings.of(context).textSignUpLabelOtherRegister,
                          maxLines: 1),
                      const Expanded(
                          child: Divider(
                        color: Colors.black,
                        indent: 15,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                          onPressed: _eventFacebook,
                          child: Image.asset(
                              'assets/images/img_facebook_logo.png')),
                      TextButton(
                          onPressed: _eventTwitter,
                          child: Image.asset(
                              'assets/images/img_twitter_logo.png')),
                      TextButton(
                          onPressed: _eventGoogle,
                          child:
                              Image.asset('assets/images/img_google_logo.png')),
                      TextButton(
                          onPressed: _eventApple,
                          child:
                              Image.asset('assets/images/img_apple_logo.png')),
                    ],
                  ),
                  const SizedBox(height: 68),
                ],
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }

  void _eventSignUp() {
    if (formKey.currentState!.validate()) {
      cubit.register(emailController.text, passwordController.text);
    }
  }

  void _eventFacebook() {}

  void _eventTwitter() {}

  void _eventGoogle() {}

  void _eventApple() {}
}
