part of 'profile_bloc.dart';

abstract class ProfileState{}

class ProfileLoadingState extends ProfileState{}

class ProfileLoadedState extends ProfileState{
  List<dynamic> loadedProfileData;
  ProfileLoadedState(this.loadedProfileData);
}

class ProfileErrorState extends ProfileState{
  String error;
  ProfileErrorState(this.error);
}