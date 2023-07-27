import 'package:flutter_bloc/flutter_bloc.dart';

/// use cubit only because here we don't have complex event only increment and decrement is there.
class InfoBloc extends Cubit<int>{
  InfoBloc() : super(0);

  int itemCount = 0;

  void increment(){
    itemCount = itemCount + 1;
    emit(state + 1);
  }

  void decrement(){
    if(state > 0){
      itemCount = itemCount - 1;
    emit(state - 1);
    }else {
      itemCount = 0;
      emit(0);
    }
  }
}