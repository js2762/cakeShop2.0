import 'package:flutter_bloc/flutter_bloc.dart';

class AllBlocObserver extends BlocObserver {

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}
