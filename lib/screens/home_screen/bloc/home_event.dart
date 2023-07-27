part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchList1Event extends HomeEvent {
}

class FetchList2Event extends HomeEvent {
}

class SelectIndexEvent extends HomeEvent {
   int index;
  SelectIndexEvent(this.index);
}

class UpdateFavouriteStatusEvent extends HomeEvent {
  int index;
  UpdateFavouriteStatusEvent(this.index);
}

class UpdateFavouriteStatusEvent2 extends HomeEvent {
  String name;
  UpdateFavouriteStatusEvent2(this.name);
}

