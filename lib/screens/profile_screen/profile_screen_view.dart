import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/screens/profile_screen/bloc/profile_bloc.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({super.key});

  static const routeName = '/ProfileScreenView';

  @override
  Widget build(BuildContext context) {
    final profileBlocInstance = BlocProvider.of<ProfileBloc>(context);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: BlocBuilder<ProfileBloc,ProfileState>(
          builder: (context, state) {
            if(state is ProfileLoadingState){
              return const CircularProgressIndicator();
            } else if(state is ProfileLoadedState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        state.loadedProfileData[0]['avatar']),
                  ),
                  Text(
                    'id : ${state.loadedProfileData[0]['id']}',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Name : ${state.loadedProfileData[0]['name']}',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            else if(state is ProfileErrorState){
              return Text(state.error);
            }
            return const Text('Something went wrong!');
          },
          bloc: profileBlocInstance..add(LoadProfileEvent()),
        ),
      ),
    ));
  }
}
