part of 'cart_bloc.dart';

abstract class CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {
  final List<Map<String, dynamic>> cartItemList;

  CartStateLoaded(this.cartItemList);
}

