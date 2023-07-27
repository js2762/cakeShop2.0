part of 'home_bloc.dart';

abstract class HomeState {}

//enum HomeState {initial, gained, lost}
class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<Map<String, String>> itemList1;
  List<CakeData> itemList2;

  HomeStateLoaded(this.itemList1, this.itemList2);
}

class HomeStateLoaded1 extends HomeState {
  final List<Map<String, String>> itemList1;

  HomeStateLoaded1(this.itemList1);
}

class HomeStateLoaded2 extends HomeState {
  List<CakeData> itemList2;

  HomeStateLoaded2(this.itemList2);
}

class HomeAddToFavouriteState extends HomeState {}
