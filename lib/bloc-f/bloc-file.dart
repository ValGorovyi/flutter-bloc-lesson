import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWorcker extends Bloc<BlocEvent, int> {

  BlocWorcker() :super(0) {
      on<BlocPlusEvent>(_onPlusEvent);
      on<BlocMinusEvent>(_onMinusEvent);
  }
  _onPlusEvent(BlocPlusEvent, Emitter<int> emit) {
    emit(state + 1);
  }
  _onMinusEvent(BlocMinusEvent, Emitter<int> emit) {
    emit(state -1);
  }


}

abstract class BlocEvent {}

class BlocPlusEvent extends BlocEvent {

}

class BlocMinusEvent extends BlocEvent {

}