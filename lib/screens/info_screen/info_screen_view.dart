import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_cake_shop/models/cake_data.dart';
import 'package:online_cake_shop/resources/app_colors.dart';
import 'package:online_cake_shop/resources/app_images.dart';
import 'package:online_cake_shop/screens/cart_screen/cart_screen_view.dart';
import 'package:online_cake_shop/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:online_cake_shop/screens/info_screen/bloc/info_bloc.dart';
import 'package:readmore/readmore.dart';

class InfoScreenView extends StatefulWidget {
  const InfoScreenView({super.key});

  static const routeName = '/InfoScreenView';

  static Widget builder(BuildContext context) {
    return BlocProvider<InfoBloc>(
      create: (_) => InfoBloc(),
      child: const InfoScreenView(),
    );
  }

  @override
  State<InfoScreenView> createState() => _InfoScreenViewState();
}

class _InfoScreenViewState extends State<InfoScreenView> {
  //final InfoCubit infoCubitInstance = InfoCubit();
  @override
  Widget build(BuildContext context) {
    CakeData argumentData =
        ModalRoute.of(context)!.settings.arguments as CakeData;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    AppImages.leftArrowBackIcon,
                    height: 30,
                    color: AppColors.lightBlackTextColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 450,
                          width: double.infinity,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: argumentData.bgColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                            ),
                          ),
                          child: Image.asset(
                            argumentData.imagePath.toString(),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          right: 30,
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: argumentData.favouriteStatus as bool
                                ? const Icon(
                                    Icons.favorite,
                                    color: AppColors.appPinkColor,
                                  )
                                : const Icon(
                                    Icons.favorite_border_rounded,
                                    color: AppColors.appPinkColor,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        argumentData.name.toString(),
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightBlackTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25, top: 10),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar(
                            ignoreGestures: true,
                            initialRating:
                                double.parse(argumentData.rating.toString()),
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            ratingWidget: RatingWidget(
                              empty: const Icon(
                                Icons.star,
                                color: AppColors.lightGreyColor,
                              ),
                              half: const Icon(
                                Icons.star_half_rounded,
                                color: Colors.orangeAccent,
                              ),
                              full: const Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              argumentData.rating.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.read<InfoBloc>().decrement();
                            },
                            child: CircleAvatar(
                              backgroundColor: argumentData.bgColor,
                              radius: 10,
                              child: const Icon(
                                Icons.remove,
                                size: 15,
                                color: AppColors.appPinkColor,
                              ),
                            ),
                          ),
                          BlocBuilder<InfoBloc, int>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Text(state.toString()),
                              );
                            },
                          ),
                          InkWell(
                            onTap: () {
                              context.read<InfoBloc>().increment();
                            },
                            child: const CircleAvatar(
                              backgroundColor: AppColors.appPinkColor,
                              radius: 10,
                              child: Icon(
                                Icons.add,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: SingleChildScrollView(
                          child: ReadMoreText(
                            argumentData.description.toString(),
                            trimLines: 7,
                            textAlign: TextAlign.justify,
                            //colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            moreStyle:
                                const TextStyle(color: AppColors.appPinkColor),
                            lessStyle:
                                const TextStyle(color: AppColors.appPinkColor),
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: argumentData.bgColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (context.read<InfoBloc>().itemCount > 0) {
                                context.read<CartBloc>().add(AddToCartEvent({
                                  'itemData': argumentData,
                                  'itemCount': context
                                      .read<InfoBloc>()
                                      .itemCount
                                      .toString()
                                }));
                                Navigator.of(context)
                                    .pushNamed(CartScreenView.routeName);
                              } else {
                                await Fluttertoast.showToast(
                                    msg: 'cart value must be greater than 0');
                              }
                            },
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                color: AppColors.appPinkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.appPinkColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "\$ ${argumentData.price}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
