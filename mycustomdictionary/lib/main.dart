import 'package:flutter/material.dart';
import 'package:mycustomdictionary/core/constants/strings/welcome_strings.dart';
import 'package:mycustomdictionary/presentation/router/app_router.dart';
import 'package:mycustomdictionary/presentation/screens/home/home_screen.dart';
import 'package:mycustomdictionary/presentation/screens/welcome/welcome_screen.dart';
import 'core/themes/app_theme.dart';

void main() {
  //Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

// TODO:popup validator
// TODO:delete functions++ is folder delete delete everythink in folder?
// TODO:popup for edit
// TODO:bug in the object title change without save
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: WelcomeStrings.appTittle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      //initialRoute: AppRounter.welcomeScreen, //after login save this maybe change as home page
      onGenerateRoute: AppRounter.onGenerateRoute,
    );
  }
}
