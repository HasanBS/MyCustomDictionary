import 'package:flutter/material.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';

import 'widgets/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/login";
    return Scaffold(
      body: Body(),
    );
  }
}
