import 'package:flutter/material.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';

import 'widgets/body.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/welcome";
    return Scaffold(
      body: Body(),
    );
  }
}
