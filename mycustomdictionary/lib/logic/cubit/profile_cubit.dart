import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mycustomdictionary/data/dataproviders/ApiConnection.dart';
import 'package:mycustomdictionary/data/models/Dictionary.dart';
import 'package:mycustomdictionary/data/models/Profile.dart';
import 'package:mycustomdictionary/data/models/ProfileScreenData.dart';
import 'package:mycustomdictionary/data/models/User.dart';
import 'package:mycustomdictionary/data/models/session.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  bool isUpdated = false;

  Future<void> myProfileScreenData() async {
    //TODO: Get data acording the user value not for active user
    var results = await Future.wait([
      ApiConnection.getDictionariesByUser(Session.activeUser!.userID),
      ApiConnection.getFollowedDictionaries(Session.activeUser!.userID),
      ApiConnection.getFollowers(Session.activeUser!.userID),
      ApiConnection.getFollowedUsers(Session.activeUser!.userID)
    ]);

    if (results is List<List<Object>>) {
      ProfileScreenData screenData = new ProfileScreenData();
      screenData.user = Session.activeUser!;
      screenData.profile = Session.profile!;
      screenData.userDictionaries = results[0] as List<Dictionary>;
      screenData.followedDictionaries = results[1] as List<Dictionary>;
      screenData.followers = results[2] as List<User>;
      screenData.followings = results[3] as List<User>;

      screenData.isOwner = true;
      //(screenData.user.userID == Session.activeUser!.userID) ? true : false;
      screenData.isFollowing = false;
      emit(ProfileLoadSuccess(screenData));
    }
  }

  Future<void> followUser(User user) async {
    final response =
        await ApiConnection.followUser(user.userID, Session.activeUser!.userID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      // follow complate
      print("follow");
      changeProfileUpdated();
    }
  }

  Future<void> unfollowUser(User user) async {
    final response = await ApiConnection.unfollowUser(
        user.userID, Session.activeUser!.userID);
    if (response.statusCode == 200 || response.statusCode == 204) {
      // unfollow complate
      print("Unfollow");
      changeProfileUpdated();
    }
  }

  Future<void> getProfileScreenData(User user) async {
    var results = await Future.wait([
      ApiConnection.getDictionariesByUser(user.userID),
      ApiConnection.getFollowedDictionaries(user.userID),
      ApiConnection.getFollowers(user.userID),
      ApiConnection.getFollowedUsers(user.userID),
      ApiConnection.getProfile(user.profileID)
    ]);

    if (results.isNotEmpty) {
      //! this control may work with emty result
      ProfileScreenData screenData = new ProfileScreenData();
      screenData.user = user;

      screenData.userDictionaries = results[0] as List<Dictionary>;
      screenData.followedDictionaries = results[1] as List<Dictionary>;
      screenData.followers = results[2] as List<User>;
      screenData.followings = results[3] as List<User>;
      screenData.profile = results[4] as Profile;
      screenData.isOwner =
          (screenData.user.userID == Session.activeUser!.userID) ? true : false;
      var contain = screenData.followers
          .where((element) => element.userID == Session.activeUser!.userID);
      screenData.isFollowing =
          (contain.isNotEmpty) //? if its not work do with for loop search
              ? true
              : false;

      emit(ProfileLoadSuccess(screenData));
    }
  }

  Future<void> updateProfile(
      String name, String surname, String description) async {
    Session.activeUser!.name = name;
    Session.activeUser!.surname = surname;
    Session.profile!.description = description;
    final editProfile = await ApiConnection.editProfile(Session.profile!);
    final editUser = await ApiConnection.editUser(Session.activeUser!);
    if ((editProfile.statusCode == 200 || editProfile.statusCode == 204) &&
        (editUser.statusCode == 200 || editUser.statusCode == 204))
      changeProfileUpdated();
  }

  void changeProfileUpdated() {
    isUpdated = !isUpdated;
    print('Updated');
    emit(ProfileUpdateState(isUpdated));
  }
}
