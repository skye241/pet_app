import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/components/component_helpers.dart';
import 'package:flutter/material.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings.of(context).TEXT_SIGNIN_TITLE,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 68.0, vertical: 62.0),
                child: Image.asset("assets/images/img_login.png"),
              ),
              ComponentHelper.textField(
                hintText: AppStrings.of(context).TEXT_SIGNIN_LABEL_EMAIL,
                label: AppStrings.of(context).TEXT_SIGNIN_LABEL_EMAIL,
              ),
              SizedBox(
                height: 18,
              ),
              ComponentHelper.textField(
                hintText: AppStrings.of(context).TEXT_SIGNIN_LABEL_PASSWORD,
                label: AppStrings.of(context).TEXT_SIGNIN_LABEL_PASSWORD,
              ),
              SizedBox(
                height: 33,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 11.54),
                  width: double.maxFinite,
                  child: Text(AppStrings.of(context).TEXT_SIGNIN_BUTTON_SIGNIN),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                        color: Colors.black,
                        endIndent: 15,
                      )),
                  Text(AppStrings.of(context).TEXT_SIGNIN_LABEL_OTHER_REGISTER,
                      maxLines: 1),
                  Expanded(
                      child: Divider(
                        color: Colors.black,
                        indent: 15,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: _eventFacebook,
                      child:
                      Image.asset("assets/images/img_facebook_logo.png")),
                  TextButton(
                      onPressed: _eventTwitter,
                      child: Image.asset("assets/images/img_twitter_logo.png")),
                  TextButton(
                      onPressed: _eventGoole,
                      child: Image.asset("assets/images/img_google_logo.png")),
                  TextButton(
                      onPressed: _eventApple,
                      child: Image.asset("assets/images/img_apple_logo.png")),
                ],
              ),
              SizedBox(height: 68),
            ],
          ),
        ),
      ),
    );
  }

  // _eventSignIn() {}

  _eventFacebook() {}

  _eventTwitter() {}

  _eventGoole() {}

  _eventApple() {}
}
