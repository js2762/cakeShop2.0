import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/services/services.dart';
//
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ApiServices apiServiceObject = ApiServices();
  ProfileBloc() : super(ProfileLoadingState()){
    on<LoadProfileEvent>((event, emit) async{
      emit(ProfileLoadingState());
      try{
        final profileData = await apiServiceObject.getUserData();
        //print(profileData);
        emit(ProfileLoadedState(profileData));
      }catch(e){
        //print(e);
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}