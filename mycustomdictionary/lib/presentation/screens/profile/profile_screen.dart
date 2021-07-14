import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/logic/cubit/profile_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/profile/settings/settings_screen.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';
import 'widgets/body.dart';

class ProfileScreen extends StatelessWidget {
  //ProfileScreenData screenData =  new ProfileScreen();
  final User? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);
  //TODO: Update there with get User
  @override
  Widget build(BuildContext context) {
    if (user != null && user is User) {
      ActivePage.route = "/profile/"+user!.profileID.toString();
      return BlocProvider(
        create: (context) => ProfileCubit()..getProfileScreenData(user as User),
        child: Scaffold(
          appBar: AppBar(
            title: Text("${user!.name + " " + user!.surname}"),
          ),
          body: Body(user: user),
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.home,
          ),
        ),
      );
    } else
      return BlocProvider(
        create: (context) => ProfileCubit()..myProfileScreenData(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("MyAccount"),
            actions: [
              //ElevatedButton(onPressed: () {}, child: Icon(Icons.edit)),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      //TODO: after check the settings part decide provider.value or send data

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => BlocProvider.value(
                      //           value: BlocProvider.of<ProfileCubit>(context),
                      //           child: SettingsScreen(),
                      //         )));
                      if (state is ProfileLoadSuccess) {
                        final profile = state.screenData.profile;
                        Navigator.of(context)
                            .pushNamed('/settings', arguments: profile);
                      }
                    },
                    child: Icon(Icons.settings),
                    style: ElevatedButton.styleFrom(
                        primary: AppTheme.lightPrimaryColor),
                  );
                },
              )
            ],
          ),
          body: Body(), //
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.profile,
          ),
        ),
      );
  }
}
