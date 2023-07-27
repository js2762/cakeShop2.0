import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/resources/app_colors.dart';
//import 'package:online_cake_shop/all_bloc_observer.dart';
import 'package:online_cake_shop/screens/profile_screen/bloc/profile_bloc.dart';
import 'package:online_cake_shop/screens/profile_screen/profile_screen_view.dart';

//
import 'screens/home_screen/home_screen_view.dart';
import 'screens/home_screen/bloc/home_bloc.dart';
import 'screens/info_screen/info_screen_view.dart';
import 'screens/cart_screen/cart_screen_view.dart';
import 'screens/cart_screen/bloc/cart_bloc.dart';
import 'screens/favourite_screen/bloc/favourite_bloc.dart';
import 'screens/favourite_screen/favourite_screen_view.dart';

void main() {
  // Bloc.observer = AllBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(FetchList2Event()),
        ),
        BlocProvider(
          create: (context) => FavouriteBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Cake Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          useMaterial3: true,
        ),
        home: HomeScreenView(),
        routes: {
          HomeScreenView.routeName: (context) => HomeScreenView(),
          InfoScreenView.routeName: (context) =>
              InfoScreenView.builder(context),
          CartScreenView.routeName: (context) => const CartScreenView(),
          FavouriteScreenView.routeName: (context) =>
              const FavouriteScreenView(),
          ProfileScreenView.routeName: (context) => const ProfileScreenView()
        },
      ),
    );
  }
}
