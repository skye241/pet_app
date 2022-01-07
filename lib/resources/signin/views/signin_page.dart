import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/resources/signin/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInCubit cubit = SignInCubit();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      bloc: cubit,
      listener: (BuildContext context, SignInState state) {
        if (state is SignInShowPopUpLoading) {
          showPopUpLoading(context);
        } else if (state is SignInShowDismissPopUpLoading) {
          Navigator.pop(context);
        } else if (state is SignInStateSuccess) {
          Navigator.pushReplacementNamed(context, RoutesName.topPage);
        } else if (state is SignInStateFail) {
          showMessage(context, AppStrings.of(context).notice, state.message,
              actions: state.message ==
                      AppStrings.of(context).textSignInErrorNotActive
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemeData.color_black_40),
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppStrings.of(context)
                                  .textPopUpCancelButtonDelete)),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.resendEmail(
                                    context, emailController.text);
                              },
                              child: Text(AppStrings.of(context).textSignInResendEmail)),
                        ),
                      ],
                    )
                  : null);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
              title: Text(
                AppStrings.of(context).textSignInTitle,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            body: BlocBuilder<SignInCubit, SignInState>(
              bloc: cubit,
              buildWhen: (SignInState prev, SignInState current) {
                if (current is! SignInInitial) {
                  return false;
                } else
                  return true;
              },
              builder: (BuildContext context, SignInState state) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 68.0, vertical: 62.0),
                          child: Image.asset('assets/images/img_login.png'),
                        ),
                        ComponentHelper.textField(
                          focusNode: emailNode,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value == null && value!.isEmpty) {
                              return AppStrings.of(context)
                                  .textSignUpErrorEmptyEmail;
                            } else if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return AppStrings.of(context)
                                  .textSignUpErrorWrongFormatEmail;
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
                            obscureText: cubit.isShow,
                            controller: passwordController,
                            onEditingComplete: () => _eventSignIn(),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.of(context)
                                    .textSignUpErrorEmptyPassword;
                              } else
                                return null;
                            },
                            hintText:
                                AppStrings.of(context).textSignUpLabelPassword,
                            label:
                                AppStrings.of(context).textSignUpLabelPassword,
                            suffix: IconButton(
                                onPressed: () =>
                                    cubit.changeShowPass(!cubit.isShow),
                                icon: Icon(
                                  cubit.isShow
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: AppThemeData.color_black_80,
                                ))),
                        const SizedBox(
                          height: 33,
                        ),
                        ElevatedButton(
                          onPressed: () => _eventSignIn(),
                          child: Container(
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.symmetric(vertical: 11.54),
                            width: double.maxFinite,
                            child: Text(
                                AppStrings.of(context).textSignInButtonSignIn),
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
                            Text(
                                AppStrings.of(context)
                                    .textSignInLabelOtherRegister,
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
                                onPressed: _eventGoole,
                                child: Image.asset(
                                    'assets/images/img_google_logo.png')),
                            TextButton(
                                onPressed: _eventApple,
                                child: Image.asset(
                                    'assets/images/img_apple_logo.png')),
                          ],
                        ),
                        const SizedBox(height: 68),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _eventSignIn() {
    if (formKey.currentState!.validate()) {
      cubit.login(emailController.text, passwordController.text, context);
    }
  }

  void _eventFacebook() {}

  void _eventTwitter() {}

  void _eventGoole() {}

  void _eventApple() {}
}
