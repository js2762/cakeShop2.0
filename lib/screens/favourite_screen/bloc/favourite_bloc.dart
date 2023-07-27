import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/models/cake_data.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';


class FavouriteBloc extends Bloc<FavouriteEvent,FavouriteState>{

  List<CakeData> favouriteItemList = [];
  List<CakeData> searchResults = [];
  TextEditingController searchControllerFavouriteItem = TextEditingController();
  bool isVisible = false;

  FavouriteBloc() : super(FavouriteStateLoading()){

    /// used to add to favourite list when user tap-on favourite status icon on home_screen_view
    on<AddToFavourite>((event, emit) {
      bool isExist = false;
      for (var i = 0; i < favouriteItemList.length; i++) {
        if (favouriteItemList[i].name == event.itemData.name) {
          favouriteItemList.removeAt(i);
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        favouriteItemList.add(event.itemData);
      }
      // cartItemList.add(itemMap);
      // print(cartItemList);
      emit(FavouriteStateLoaded(favouriteItemList));
    });

    /// toggle visibility of search TextField
    on<FavouriteToggleVisibilityEvent>((event, emit) {
      isVisible = !isVisible;
      emit(FavouriteStateLoaded(favouriteItemList));
    });

    /// removing from favourite_screen_view
    on<RemoveFromFavouriteEvent>((event, emit) {
      favouriteItemList.removeWhere((element) => element.name == event.name);
      searchResults.removeWhere((element) => element.name == event.name);
      //favouriteItemList = favouriteItemList;
      emit(FavouriteStateLoaded(favouriteItemList));
    });

    /// for searching favourite element
    on<FavouriteSearchedEvent>((event, emit) {
      //searchResults.clear();
      if(event.value.isNotEmpty){
        searchResults = favouriteItemList.where((element) =>(element.name)!.toLowerCase().contains(event.value.toLowerCase())).toList();
      }else if(event.value == ''){
        searchResults = favouriteItemList;
      }
      emit(FavouriteStateLoaded(searchResults));
    });

  }



}

