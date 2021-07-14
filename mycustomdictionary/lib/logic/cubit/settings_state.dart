part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class ProfileSettingsState extends SettingsState {
  ProfileSettingsState(this.profileSettings);
  final ProfileSettings profileSettings;
}

class NotificationSettingsState extends SettingsState {
  NotificationSettingsState(this.notificationSettings);
  final NotificationSettings notificationSettings;
}
