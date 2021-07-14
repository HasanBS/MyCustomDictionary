import 'package:flutter/material.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'widgets/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/signup";
    return Scaffold(
      body: Body(),
    );
  }
}
