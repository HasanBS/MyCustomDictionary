import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Word.dart';
import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'components/body.dart';

class WordScreen extends StatelessWidget {
  final Word word;
  final bool readOnly;

  const WordScreen({Key? key, required this.word, required this.readOnly})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/dictionary/word"+word.wordID.toString();
    if (readOnly)
      return Scaffold(
        appBar: AppBar(
          title: Text(word.word),
        ),
        body: Body(
          word: word,
          readOnly: readOnly,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.home,
        ),
      );
    else
      return BlocBuilder<WordCubit, WordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(word.word),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<WordCubit>().updateWord(word);
                    },
                    child: state is WordLoadingState
                        ? (state.isLoading
                            ? Icon(Icons.timer)
                            : Icon(Icons.save_alt_rounded))
                        : Icon(Icons.save_alt_rounded),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        primary: AppTheme.lightPrimaryColor),
                  ),
                )
              ],
            ),
            body: Body(
              word: word,
              readOnly: readOnly,
            ),
            bottomNavigationBar: CustomBottomNavBar(
              selectedMenu: MenuState.folder,
            ),
          );
        },
      );
  }
}
