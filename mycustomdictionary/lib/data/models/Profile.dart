import 'dart:convert';

class Profile {
  int profileID;
  String profilePicture;
  String description;
  int profileSettingsID;

  Profile(
    this.profileID,
    this.profilePicture,
    this.description,
    this.profileSettingsID,
  );

  Map<String, dynamic> toMap() {
    return {
      'profileId': profileID,
      'profilePicture': profilePicture,
      'description': description,
      'profileSettingsId': profileSettingsID,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      map['profileId'],
      map['profilePicture'],
      map['description'],
      map['profileSettingsId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(profileID: $profileID, profilePicture: $profilePicture, description: $description, profileSettingsID: $profileSettingsID)';
  }
}
