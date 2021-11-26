import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/model/enum.dart';
import 'package:flutter/material.dart';

class TermPage extends StatelessWidget {
  const TermPage({Key? key, required this.termType}) : super(key: key);

  final int termType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(termType == TermType.serviceTerm
            ? AppStrings.of(context).textRuleService
            : AppStrings.of(context).textPolicyProtected),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Text(
              termType == TermType.serviceTerm
                  ? AppStrings.of(context).textRuleService
                  : AppStrings.of(context).textPolicyProtected,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi aliquam et sem tristique aliquet pellentesque venenatis. Sed eget urna sed dictum eros quis nunc, dictum faucibus. Mauris etiam mattis a diam viverra.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
