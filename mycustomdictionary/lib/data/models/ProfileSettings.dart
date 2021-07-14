import 'dart:convert';

class ProfileSettings {
  int profileSettingsID;
  bool hideProfile;
  bool hideProfilePicture;
  bool hideName;
  // bool hideJob;
  // bool hideSchool;

  ProfileSettings(
    this.profileSettingsID,
    this.hideProfile,
    this.hideProfilePicture,
    this.hideName,
  );

  Map<String, dynamic> toMap() {
    return {
      'profileSettingsId': profileSettingsID,
      'hideProfile': hideProfile,
      'hideProfilePicture': hideProfilePicture,
      'hideName': hideName,
    };
  }

  factory ProfileSettings.fromMap(Map<String, dynamic> map) {
    return ProfileSettings(
      map['profileSettingsId'],
      map['hideProfile'],
      map['hideProfilePicture'],
      map['hideName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileSettings.fromJson(String source) =>
      ProfileSettings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileSettings(profileSettingsID: $profileSettingsID, hideProfile: $hideProfile, hideProfilePicture: $hideProfilePicture, hideName: $hideName)';
  }
}
