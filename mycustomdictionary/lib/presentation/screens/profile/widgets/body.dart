import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycustomdictionary/core/constants/strings/profile_strings.dart';
import 'package:mycustomdictionary/core/themes/app_theme.dart';
import 'package:mycustomdictionary/data/models/ProfileScreenData.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/session.dart';
import 'package:mycustomdictionary/logic/cubit/profile_cubit.dart';
import 'package:mycustomdictionary/presentation/screens/folder/widgets/dictionary_field.dart';
import 'package:mycustomdictionary/presentation/screens/profile/EditProfile/edit_profile_screen.dart';

import 'account_description_field.dart';
import 'custom_numer_button.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  final User? user;
  late ProfileScreenData screenData;

  Body({Key? key, this.user}) : super(key: key);
  //ProfileScreenData screenData;
  //bool isOwner;
  //bool isFollowing;
  //int followerCount;
  //int followingCount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateState) {
          if (screenData.isOwner) {
            context.read<ProfileCubit>().myProfileScreenData();
          } else {
            context.read<ProfileCubit>().getProfileScreenData(user!);
          }
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadSuccess) {
          screenData = state
              .screenData; //TODO: get this acording the user in constructer
          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      //dictionaries buraya
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                                backgroundImage:
                                    //NetworkImage(
                                    //    "https://pps.whatsapp.net/v/t61.24694-24/64382453_2554944074734484_6815667573204451328_n.jpg?ccb=11-4&oh=060504c7c3f4d9d67ea14f94aa22feb2&oe=60E65392")
                                    AssetImage("assets/images/profile.png")),
                          ),
                          SizedBox(height: 5),
                          Text(
                            screenData.user.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomNumberButton(
                                tittle: ProfileStrings.dictionary,
                                number: screenData.userDictionaries.length
                                    .toString(),
                                onPressed: () async {},
                              ),
                              CustomNumberButton(
                                tittle: ProfileStrings.followers,
                                number: screenData.followers.length.toString(),
                                onPressed: () async {
                                  Navigator.of(context).pushNamed("/list",
                                      arguments: state.screenData.followers);
                                },
                              ),
                              CustomNumberButton(
                                tittle: ProfileStrings.following,
                                number: screenData.followings.length.toString(),
                                onPressed: () async {
                                  Navigator.of(context).pushNamed("/list",
                                      arguments: state.screenData.followings);
                                },
                              ),
                            ],
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppTheme.lightPrimaryWordAddButtonColor,
                            ),
                            onPressed: () {
                              if (screenData.isOwner) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<ProfileCubit>(
                                              context),
                                          child: EditProfileScreen(),
                                        )));
                              } else if (!screenData.isFollowing) {
                                screenData.isFollowing = true;

                                context
                                    .read<ProfileCubit>()
                                    .followUser(screenData.user);
                              } else if (screenData.isFollowing) {
                                screenData.isFollowing = false;

                                context
                                    .read<ProfileCubit>()
                                    .unfollowUser(screenData.user);
                              }
                            },
                            child: SizedBox(
                                width: 96,
                                child: Row(
                                  children: [
                                    if (screenData.isOwner)
                                      Text(ProfileStrings.editProfile),
                                    if (!screenData.isOwner &&
                                        !screenData.isFollowing)
                                      Text(ProfileStrings.follow),
                                    if (!screenData.isOwner &&
                                        screenData.isFollowing)
                                      Text(ProfileStrings.unfollow),
                                    SizedBox(width: 3),
                                    //if(isOwner)
                                    if (screenData.isOwner) Icon(Icons.edit),
                                    if (!screenData.isOwner &&
                                        !screenData.isFollowing)
                                      Icon(Icons.check),
                                    if (!screenData.isOwner &&
                                        screenData.isFollowing)
                                      Icon(Icons.close),
                                  ],
                                )),
                          ),

                          AccountDescriptionField(
                            nameSurname: screenData.user.name +
                                " " +
                                screenData.user.surname,
                            description: screenData.profile.description,
                          ),

                          //ProfileDictionaryNavBar(),
                          //bu bolum baskasinin hesabina bakarken gozukmemeli
                          //cunku baskasinin hesabinda sadece onun paylastigi sozlukler gorunecek secenek yok
                        ],
                      ),
                    ]),
                  ),
                ];
              },
              body: Column(
                children: [
                  TabBar(
                    labelColor: AppTheme.lightPrimaryColor,
                    tabs: [
                      Tab(text: ProfileStrings.dictionaries),
                      Tab(text: ProfileStrings.followedDictionaries)
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(
                          children: [
                            for (var i = 0;
                                i < screenData.userDictionaries.length;
                                i++)
                              DictionaryField(
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        "/dictionary",
                                        arguments:
                                            screenData.userDictionaries[i]);
                                  },
                                  // dictionaryID: screenData
                                  //     .userDictionaries[i].dictionaryID,
                                  description: screenData
                                      .userDictionaries[i].description,
                                  dictionaryName: screenData
                                      .userDictionaries[i].dictionaryName),

                            ///bizimi sozlukler buraya
                          ],
                        ),
                        ListView(
                          children: [
                            for (var i = 0;
                                i < screenData.followedDictionaries.length;
                                i++)
                              DictionaryField(
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        "/dictionary",
                                        arguments:
                                            screenData.followedDictionaries[i]);
                                  },
                                  // dictionaryID: screenData
                                  //     .followedDictionaries[i].dictionaryID,
                                  description: screenData
                                      .followedDictionaries[i].description,
                                  dictionaryName: screenData
                                      .followedDictionaries[i].dictionaryName),
                            //takip edilen sozlukler buraya
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else
          return Container(); //TODO: for the unsuccessful load create screen
      },
    );
  }
}
