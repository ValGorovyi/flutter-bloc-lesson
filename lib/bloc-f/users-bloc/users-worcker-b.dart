import 'package:b_l/bloc-f/users-bloc/users-event-b.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users-state-b.dart';

class UserBlocWorcker extends Bloc<UsersEventB, UsersStateB> {
  UserBlocWorcker() : super(InitialUserState()) {
    on<CreateUsEvent>(_onCreateUsers);
  }

  _onCreateUsers(CreateUsEvent event, Emitter<UsersStateB> emit) async {
    emit(UserLoadingState()); // imitacia zagruzki
    await Future.delayed(Duration(seconds: 1));
    final users = List.generate(
        event.count,
        (index) =>
            User(id: index.toString(), name: 'user name ' + index.toString()));
    emit(UserLoadedState(users));
  }
}
