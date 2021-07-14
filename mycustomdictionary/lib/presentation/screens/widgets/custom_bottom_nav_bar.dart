import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Folder.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final MenuState selectedMenu;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerFolder = Session.mainFolder;
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: MenuState.home == selectedMenu
                    ? AppTheme.lightPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                Session.updateNotifications();
                print(ActivePage.route);
                if (ActivePage.route != "/home") {
                  ActivePage.route = "/home";
                  Navigator.of(context).pushNamed('/home');
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.folder),
              color: MenuState.folder == selectedMenu
                  ? AppTheme.lightPrimaryColor
                  : inActiveIconColor,
              onPressed: () {
                print(ActivePage.route);
                if (ActivePage.route !=
                    "/folder/" + Session.activeUser!.rootFolderID.toString()) {
                  ActivePage.route =
                      "/folder/" + Session.activeUser!.rootFolderID.toString();
                  Navigator.of(context).pushNamed('/folder',
                      arguments:
                          routerFolder); //! profileden sonra foldera giris olmamakta
                }
                //Navigator.pushNamed(context, FolderScreen.routeName, arguments: Session.mainFolder);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: MenuState.profile == selectedMenu
                  ? AppTheme.lightPrimaryColor
                  : inActiveIconColor,
              onPressed: () async {
                print(ActivePage.route);
                if (ActivePage.route !=
                    "/profile/" + Session.activeUser!.profileID.toString()) {
                  ActivePage.route =
                      "/profile/" + Session.activeUser!.profileID.toString();
                  Navigator.of(context).pushNamed('/profile');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
