import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/models/cake_data.dart';
import 'package:online_cake_shop/resources/app_colors.dart';
import 'package:online_cake_shop/resources/app_images.dart';
import 'package:online_cake_shop/screens/favourite_screen/bloc/favourite_bloc.dart';
import 'package:online_cake_shop/screens/home_screen/bloc/home_bloc.dart';
import 'package:online_cake_shop/screens/home_screen/home_screen_view.dart';


class FavouriteScreenView extends StatelessWidget {
  const FavouriteScreenView({super.key});

  static const routeName = '/FavouriteScreenView';

  // static Widget builder(BuildContext context) {
  //   return BlocProvider<CartCubit>(
  //     create: (_) => CartCubit(),
  //     child: const CartScreenView(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
   /// HomeCubit homeCubitInstance = ModalRoute.of(context)!.settings.arguments as HomeCubit;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      AppImages.leftArrowBackIcon,
                      height: 25,
                      color: AppColors.lightBlackTextColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Favourite items',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBlackTextColor),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<FavouriteBloc>().add(FavouriteToggleVisibilityEvent());
                    },
                    child: Image.asset(
                      AppImages.searchIcon,
                      height: 30,
                      color: AppColors.lightBlackTextColor,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: context.watch<FavouriteBloc>().isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: context
                        .read<FavouriteBloc>()
                        .searchControllerFavouriteItem,
                    onChanged: (value) {
                      context.read<FavouriteBloc>().add(FavouriteSearchedEvent(value));
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){
                          context.read<FavouriteBloc>().add(FavouriteToggleVisibilityEvent());
                        },
                        icon: const Icon(Icons.highlight_remove_rounded,size: 35,color: AppColors.appPinkColor,),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                          color: AppColors.appPinkColor, fontSize: 18),
                      //focusColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColors.appPinkColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColors.appPinkColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColors.appPinkColor, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColors.appPinkColor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20),
                  child: BlocBuilder<FavouriteBloc, FavouriteState>(
                    builder: (context, state) {
                      if (state is FavouriteStateLoading) {
                        return const Center(
                            child: Text('Not have data to show...'));
                      } else if (state is FavouriteStateLoaded) {
                        if (state.favouriteItemList.isEmpty) {
                          return const Center(
                              child: Text('Not have data to show...'));
                        }
                        return ListView.builder(
                          itemCount: state.favouriteItemList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: customCakeCartCard(
                                    itemData: state.favouriteItemList[index],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ///homeCubitInstance.updateFavouriteStatus2(state.favouriteItemList[index].name.toString());
                                    context.read<HomeBloc>().add(UpdateFavouriteStatusEvent2(state.favouriteItemList[index].name.toString()));
                                    ///BlocProvider.of<HomeCubit>(context).updateFavouriteStatus2(state.favouriteItemList[index].name.toString());
                                    context.read<FavouriteBloc>().add(RemoveFromFavouriteEvent(state.favouriteItemList[index].name.toString(), state.favouriteItemList));
                                  },
                                  icon: const Icon(
                                    Icons.favorite_rounded,
                                    color: AppColors.appPinkColor,
                                    size: 35,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return const Text('Something went wrong!');
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appPinkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreenView.routeName,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Find More',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customCakeCartCard({
  required CakeData itemData,
}) {
  return FittedBox(
    child: Container(
      height: 140,
      width: 320,
      //width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: Container(
              height: 100,
              width: 300,
              //width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    width: 100,
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
                              fontSize: 16,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 38,
            left: 10,
            child: Container(
              height: 100,
              width: 100,
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
          ),
        ],
      ),
    ),
  );
}
