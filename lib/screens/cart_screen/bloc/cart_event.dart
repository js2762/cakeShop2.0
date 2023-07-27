part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  Map<String, dynamic> itemMap;
  AddToCartEvent(this.itemMap);
}

class CartToggleVisibilityEvent extends CartEvent {}

class CartSearchedEvent extends CartEvent{
  String value;
  CartSearchedEvent(this.value);
}

class RemoveFromCartEvent extends CartEvent{
  String name;
  List<Map<String, dynamic>> cartItemList2;
  RemoveFromCartEvent(this.name,this.cartItemList2);
}

