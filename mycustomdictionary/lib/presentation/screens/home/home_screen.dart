import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/home_strings.dart';
import 'package:mycustomdictionary/logic/cubit/search_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'widgets/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/home";
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(HomeStrings.title),
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.home,
        ),
      ),
    );
  }
}
