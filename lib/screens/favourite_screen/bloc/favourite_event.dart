part of 'favourite_bloc.dart';

abstract class FavouriteEvent {}

class AddToFavourite extends FavouriteEvent{
  CakeData itemData;
  AddToFavourite(this.itemData);
}

class FavouriteToggleVisibilityEvent extends FavouriteEvent {
}

class RemoveFromFavouriteEvent extends FavouriteEvent {
  //int index;
  String name;
  List<CakeData> favouriteItemList2;
  RemoveFromFavouriteEvent(this.name,this.favouriteItemList2);
}

class FavouriteSearchedEvent extends FavouriteEvent {
  String value;
  FavouriteSearchedEvent(this.value);
}

