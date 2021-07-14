import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mycustomdictionary/core/constants/enums.dart';
import 'package:mycustomdictionary/core/constants/strings/dictionary_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/dictionary_cubit.dart';

import 'package:mycustomdictionary/logic/cubit/word_cubit.dart';
import 'package:mycustomdictionary/presentation/router/active_page.dart';
import 'package:mycustomdictionary/presentation/screens/widgets/custom_bottom_nav_bar.dart';

import 'components/body.dart';
import 'components/fab_add_button.dart';

class DictionaryScreen extends StatelessWidget {
  final Dictionary dictionary;

  const DictionaryScreen({
    Key? key,
    required this.dictionary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivePage.route = "/dictionary/" + dictionary.dictionaryID.toString();
    bool isOwner;
    isOwner =
        dictionary.userID == Session.activeUser!.userID; //* send this to cubit
    return BlocProvider(
      create: (context) => WordCubit(dictionary)..getWords(),
      child: Scaffold(
        appBar: !isOwner
            ? AppBar(title: Text(dictionary.dictionaryName), actions: [
                BlocProvider(
                  create: (context) => DictionaryCubit()
                    ..toFollowingState(
                        Session.activeUser!.userID, dictionary.dictionaryID),
                  child: BlocBuilder<DictionaryCubit, DictionaryState>(
                      builder: (context, state) {
                    Widget followButton() {
                      if (state is DictionaryFollowState) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<DictionaryCubit>().unfollowDictionary(
                                Session.activeUser!.userID,
                                dictionary.dictionaryID);
                          },
                          child: Text(DictionaryStrings.unfollow),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              primary: AppTheme.lightPrimaryColor),
                        );
                      } else if (state is DictionaryUnFollowState) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<DictionaryCubit>().followDictionary(
                                Session.activeUser!.userID,
                                dictionary.dictionaryID);
                          },
                          child: Text(DictionaryStrings.follow),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              primary: AppTheme.lightPrimaryColor),
                        );
                      } else
                        return Container();
                    }

                    return Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: followButton());
                  }),
                )
              ])
            : AppBar(title: Text(dictionary.dictionaryName)),
        body: Body(
          dictionary: dictionary,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.folder,
        ),
        floatingActionButton:
            isOwner ? FabAddButton(dictionary.dictionaryID) : null,
      ),
    );
  }
}
