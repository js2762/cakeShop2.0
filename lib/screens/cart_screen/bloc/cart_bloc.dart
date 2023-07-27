import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_cake_shop/models/cake_data.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Map<String, dynamic>> cartItemList = [];
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController searchControllerCartItem = TextEditingController();
  bool isVisible = false;

  CartBloc() : super(CartStateLoading()) {
    /// for adding into cartList from info_screen_view
    on<AddToCartEvent>((event, emit) {
      bool isExist = false;
      for (var i = 0; i < cartItemList.length; i++) {
        if ((cartItemList[i]['itemData'] as CakeData).name ==
            (event.itemMap['itemData'] as CakeData).name) {
          cartItemList[i] = event.itemMap;
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        cartItemList.add(event.itemMap);
      }
      // cartItemList.add(itemMap);
      // print(cartItemList);
      emit(CartStateLoaded(cartItemList));
    });

    /// for toggle visibility of textFromField
    on<CartToggleVisibilityEvent>((event, emit) {
      isVisible = !isVisible;
      //print(isVisible);
      emit(CartStateLoaded(cartItemList));
    });

    /// for searching cart elements
    on<CartSearchedEvent>((event, emit) {
      //searchResults.clear();
      if (event.value.isNotEmpty) {
        searchResults = cartItemList
            .where((element) => (element['itemData'] as CakeData)
                .name!
                .toLowerCase()
                .contains(event.value.toLowerCase()))
            .toList();
      } else if (event.value == '') {
        searchResults = cartItemList;
      }
      emit(CartStateLoaded(searchResults));
    });

    /// for removing cart element from cart list
    on<RemoveFromCartEvent>((event, emit) {
     // event.cartItemList2.removeAt(event.index);
     // event.cartItemList2.removeWhere((element) => (element['itemData'] as CakeData).name == event.name);
      // cartItemList = event.cartItemList2;
      //print(cartItemList);
      cartItemList.removeWhere((element) => (element['itemData'] as CakeData).name == event.name);
      searchResults.removeWhere((element) => (element['itemData'] as CakeData).name == event.name);
      emit(CartStateLoaded(cartItemList));
    });
  }
}
