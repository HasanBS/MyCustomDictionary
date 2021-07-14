part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  ProfileLoadSuccess(this.screenData);
  final ProfileScreenData screenData;
}

class ProfileLoadingState extends ProfileState {
  final bool isLoading;
  ProfileLoadingState(this.isLoading);
}

class ProfileLoginError extends ProfileState {
  final String message;
  ProfileLoginError(this.message);
}

class ProfileUpdateState extends ProfileState {
  final bool isUpdated;
  ProfileUpdateState(this.isUpdated);
}
