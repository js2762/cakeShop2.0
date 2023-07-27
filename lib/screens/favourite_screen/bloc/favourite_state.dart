part of 'favourite_bloc.dart';

abstract class FavouriteState {}

class FavouriteStateLoading extends FavouriteState {}

class FavouriteStateLoaded extends FavouriteState {
  final List<CakeData> favouriteItemList;

  FavouriteStateLoaded(this.favouriteItemList);
}