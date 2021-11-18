import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:flutter/material.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings.of(context).textSignInTitle,
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
                child: Image.asset('assets/images/img_login.png'),
              ),
              ComponentHelper.textField(
                hintText: AppStrings.of(context).textSignInLabelEmail,
                label: AppStrings.of(context).textSignInLabelEmail,
              ),
              const SizedBox(
                height: 18,
              ),
              ComponentHelper.textField(
                hintText: AppStrings.of(context).textSignInLabelPassword,
                label: AppStrings.of(context).textSignInLabelPassword,
              ),
              const SizedBox(
                height: 33,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 11.54),
                  width: double.maxFinite,
                  child: Text(AppStrings.of(context).textSignInButtonSignIn),
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
                  Text(AppStrings.of(context).textSignInLabelOtherRegister,
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
                      child:
                      Image.asset('assets/images/img_facebook_logo.png')),
                  TextButton(
                      onPressed: _eventTwitter,
                      child: Image.asset('assets/images/img_twitter_logo.png')),
                  TextButton(
                      onPressed: _eventGoole,
                      child: Image.asset('assets/images/img_google_logo.png')),
                  TextButton(
                      onPressed: _eventApple,
                      child: Image.asset('assets/images/img_apple_logo.png')),
                ],
              ),
              const SizedBox(height: 68),
            ],
          ),
        ),
      ),
    );
  }

  // _eventSignIn() {}

  void _eventFacebook() {}

  void _eventTwitter() {}

  void _eventGoole() {}

  void _eventApple() {}
}
