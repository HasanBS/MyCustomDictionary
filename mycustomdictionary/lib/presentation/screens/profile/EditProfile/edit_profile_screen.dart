import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/edit_profile_strings.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'widgets/body.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/editProfile";
    return Scaffold(
      appBar: AppBar(
        title: Text(EditProfileStrings.title),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
    //change name surname
    //change description
    //change pic
  }
}
