import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';
import 'widgets/body.dart';

class ListScreen extends StatelessWidget {
  final List<dynamic> data;
  const ListScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/list/";
    return Scaffold(
        appBar: AppBar(
          title: Text("List of Items"),
        ),
        body: Body(data: data),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.home,
        ));
  }
}
