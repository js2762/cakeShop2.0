import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/models/cake_data.dart';
import 'package:online_cake_shop/resources/app_colors.dart';
import 'package:online_cake_shop/resources/app_images.dart';
import 'package:online_cake_shop/screens/cart_screen/cart_screen_view.dart';
import 'package:online_cake_shop/screens/favourite_screen/bloc/favourite_bloc.dart';
import 'package:online_cake_shop/screens/favourite_screen/favourite_screen_view.dart';
import 'package:online_cake_shop/screens/home_screen/bloc/home_bloc.dart';
import 'package:online_cake_shop/screens/info_screen/info_screen_view.dart';
import 'package:online_cake_shop/screens/profile_screen/profile_screen_view.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  static const routeName = '/HomeScreenView';

  // static Widget builder(BuildContext context) {
  //   return BlocProvider<HomeCubit>(
  //     create: (_) => HomeCubit(),
  //     child:  HomeScreenView(),
  //   );
  // }

  final HomeBloc _list1Bloc = HomeBloc();
  final HomeBloc _list2Bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreenView.routeName);
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: AppColors.appPinkColor,
                    radius: 25,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Will you have\n',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appPinkColor,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: AppColors.appLightPinkColor,
                                offset: Offset(0, 3.5),
                              )
                            ],
                          ),
                        ),
                        TextSpan(
                          text: 'some more\n',
                          style: TextStyle(
                            fontSize: 28,
                            color: AppColors.lightGreyColor,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: AppColors.appLightPinkColor,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                        ),
                        TextSpan(
                          text: 'cake?',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlackTextColor,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: AppColors.appLightPinkColor,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyDropShadowColor,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Image.asset(
                        AppImages.searchIcon,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyDropShadowColor,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(FavouriteScreenView.routeName);

                        ///arguments: _list2Cubit
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Image.asset(
                          AppImages.wishListIcon,
                          height: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyDropShadowColor,
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CartScreenView.routeName);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeStateLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeStateLoaded1) {
                    return Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.itemList1.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: _list1Bloc.selectedIndex == index
                                ? selectedCategory(
                                    name: state.itemList1[index]['name']
                                        .toString(),
                                    imagePath: state.itemList1[index]
                                            ['imagePath']
                                        .toString(),
                                  )
                                : InkWell(
                                    onTap: () {
                                      //_list1Cubit.selectCategory(index);
                                      _list1Bloc.add(SelectIndexEvent(index));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppColors.appLightPinkColor,
                                      radius: 30,
                                      child: Image.asset(
                                          state.itemList1[index]['imagePath']
                                              .toString(),
                                          height: 25),
                                    ),
                                  ),
                          );
                        },
                      ),
                    );
                  }
                  return const Text('Something went wrong!');
                },
                bloc: _list1Bloc..add(FetchList1Event()),
              ),
              // selectedCategory(),
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeAddToFavouriteState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.pinkAccent,
                        content: Text('Successfully add to wishlist'),
                      ),
                    );
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeStateLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is HomeStateLoaded2) {
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.itemList2.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                final arguments = state.itemList2[index];
                                Navigator.of(context).pushNamed(
                                    InfoScreenView.routeName,
                                    arguments: arguments);
                              },
                              child: customCakeCard(
                                itemData: state.itemList2[index],
                                index: index,
                                context: context,
                                //homeInstance: _list2Bloc,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Text('Something went wrong!');
                  },
                  // bloc: _list2Bloc..add(FetchList2Event()),
                ),
              ),
              const Text(
                'Recommended',
                style: TextStyle(
                    color: AppColors.lightBlackTextColor, fontSize: 24),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeStateLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is HomeStateLoaded2) {
                    return SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.itemList2.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              final arguments = state.itemList2[index];
                              Navigator.of(context).pushNamed(
                                  InfoScreenView.routeName,
                                  arguments: arguments);
                            },
                            child: customCakeCard2(
                              itemData: state.itemList2[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Text('Something went wrong!');
                },
                //bloc: _list2Bloc..add(FetchList2Event()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget selectedCategory({String? name, String? imagePath}) {
  return Container(
    height: 60,
    width: 140,
    padding: const EdgeInsets.only(left: 12, right: 12),
    decoration: BoxDecoration(
      color: AppColors.appPinkColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Image.asset(
            imagePath.toString(),
            height: 25,
          ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            //alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                name.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customCakeCard2({
  required CakeData itemData,
}) {
  return Container(
    height: 120,
    width: 270,
    color: Colors.white,
    margin: const EdgeInsets.only(right: 5),
    child: Stack(
      children: [
        Positioned(
          top: 15,
          left: 10,
          child: Container(
            height: 80,
            width: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.greyDropShadowColor,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          itemData.name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlackTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        'Flavour: ${itemData.flavour}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${itemData.price.toString()}',
                            style: TextStyle(color: itemData.color),
                          ),
                          Container(
                            height: 20,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                //color: Colors.deepPurpleAccent,
                                color: itemData.color,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              'Buy Now',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 35,
          left: 10,
          child: Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: itemData.bgColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Image.asset(itemData.imagePath.toString()),
          ),
        )
      ],
    ),
  );
}

Widget customCakeCard({
  required CakeData itemData,
  required BuildContext context,
  required int index,
  //required HomeBloc homeInstance,
}) {
  return Container(
    height: 300,
    width: 225,
    margin: const EdgeInsets.only(left: 15),
    color: Colors.white,
    child: Stack(
      children: [
        Positioned(
          left: 10,
          bottom: 20,
          child: Container(
            height: 180,
            width: 205,
            padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.greyDropShadowColor,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(-1.5, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                FittedBox(
                  child: Text(
                    itemData.name.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBlackTextColor,
                        fontSize: 16),
                  ),
                ),
                Text(
                  'Flavour: ${itemData.flavour}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${itemData.price.toString()}',
                      style: TextStyle(color: itemData.color),
                    ),
                    Container(
                      height: 25,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: itemData.color,
                          //  color: color,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 30,
          child: Stack(
            children: [
              Container(
                height: 180,
                width: 185,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: itemData.bgColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Image.asset(itemData.imagePath.toString()),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    //homeInstance.updateFavouriteStatus(index);
                    context
                        .read<HomeBloc>()
                        .add(UpdateFavouriteStatusEvent(index));
                    context.read<FavouriteBloc>().add(AddToFavourite(itemData));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 14,
                    child: itemData.favouriteStatus as bool
                        ? const Icon(
                            Icons.favorite,
                            color: AppColors.appPinkColor,
                            size: 18,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: AppColors.appPinkColor,
                            size: 18,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
/*    Center(
            child: BlocBuilder<HomeCubit,HomeState>(
              builder: (context, state) {
                if(state.itemList.isEmpty){
                  return CircularProgressIndicator();
                }else{
                  return ListView.builder(
                    itemCount: state.itemList.length,
                    itemBuilder: (context, index) {
                      return Text(state.itemList[index]);
                    },
                  );
                }
              },

            ),
          ) */
