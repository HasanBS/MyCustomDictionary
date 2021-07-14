import 'package:flutter/material.dart';

import 'Dictionary.dart';
import 'Profile.dart';
import 'User.dart';

class ProfileScreenData {
  late User user;
  late Profile profile;
  late List<Dictionary> userDictionaries;
  late List<Dictionary> followedDictionaries;
  late List<User> followers;
  late List<User> followings;
  late bool isOwner;
  late bool isFollowing;
  // ProfileScreenData({
  //   Key? key,
  //   required this.user,
  //   required this.profile,
  //   required this.userDictionaries,
  //   required this.followedDictionaries,
  //   required this.followers,
  //   required this.followings,
  // });
}
