import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/folder_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/folder_cubit.dart';
import 'package:mycustomdictionary/logic/cubit/note_cubit.dart';

import 'Popup/create_popup_card.dart';
import 'Popup/custom_rect_tween.dart';
import 'Popup/hero_dialog_route.dart';

class FabMenu extends StatefulWidget {
  final int currentFolder;
  FabMenu(this.currentFolder);
  @override
  _FabMenuState createState() => _FabMenuState(currentFolder);
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  int currentFolder;
  _FabMenuState(this.currentFolder);
  AnimationController? animationController;
  Animation? degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation? rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController!);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController!);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController!);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut));
    super.initState();
    animationController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              right: 0, // set the position of the icon
              bottom: 0, //
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IgnorePointer(
                    child: Container(
                      color: Colors.transparent,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degOneTranslationAnimation!.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation!.value))
                        ..scale(degOneTranslationAnimation!.value),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'Create-Dic',
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin!, end: end!);
                        },
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          child: CircularButton(
                            color: Color(0xFFf1e6ff),
                            width: 50,
                            height: 50,
                            icon: Icon(
                              Icons.book,
                              color: Colors.purple,
                            ),
                            onClick: () {
                              Navigator.of(context)
                                  .push(HeroDialogRoute(builder: (_) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<DictionaryCubit>(
                                        context),
                                    child: CreatePopupCard(
                                      heroAddTodo: 'Create-Dic',
                                      folderID: currentFolder,
                                      nameHintText: FolderStrings
                                          .dictionaryName, //Folder id for set the root of the create
                                    ));
                              }));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degTwoTranslationAnimation!.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation!.value))
                        ..scale(degTwoTranslationAnimation!.value),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'Create-Note',
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin!, end: end!);
                        },
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          child: CircularButton(
                            color: Color(0xFFFDDBB0),
                            width: 50,
                            height: 50,
                            icon: Icon(
                              Icons.note_rounded,
                              color: AppTheme.lightPrimaryColor,
                            ),
                            onClick: () {
                              Navigator.of(context)
                                  .push(HeroDialogRoute(builder: (_) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<NoteCubit>(context),
                                    child: CreatePopupCard(
                                      heroAddTodo: 'Create-Note',
                                      folderID: currentFolder,
                                      nameHintText: FolderStrings.noteName,
                                    ));
                              }));

                              // Navigator.of(context)
                              //     .push(HeroDialogRoute(builder: (context) {
                              //   return CreatePopupCard(
                              //     heroAddTodo: 'Create-Note',
                              //     folderID: currentFolder,
                              //     nameHintText: "Note Name",
                              //   );
                              // }));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degThreeTranslationAnimation!.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation!.value))
                        ..scale(degThreeTranslationAnimation!.value),
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'Create-Folder',
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin!, end: end!);
                        },
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          child: CircularButton(
                            color: Color(0xFFADCBFF),
                            width: 50,
                            height: 50,
                            icon: Icon(
                              Icons.folder_open,
                              color: AppTheme.lightPrimaryColor,
                            ),
                            onClick: () {
                              Navigator.of(context)
                                  .push(HeroDialogRoute(builder: (_) {
                                return BlocProvider.value(
                                    value:
                                        BlocProvider.of<FolderCubit>(context),
                                    child: CreatePopupCard(
                                      heroAddTodo: 'Create-Folder',
                                      folderID: currentFolder,
                                      nameHintText: FolderStrings.folderName,
                                    ));
                              }));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation!.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: AppTheme.lightPrimaryFabButtonColor,
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onClick: () {
                        if (animationController!.isCompleted) {
                          animationController!.reverse();
                        } else {
                          animationController!.forward();
                        }
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final VoidCallback onClick;

  CircularButton(
      {required this.color,
      required this.width,
      required this.height,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
