import 'package:b_l/bloc-f/users-bloc/users-event-b.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users-state-b.dart';

class UserBlocWorcker extends Bloc<UsersEventB, UsersStateB> {
  UserBlocWorcker() : super(UsersStateB()) {
    on<CreateUsEvent>(_onCreateUsers);
    on<CreateJobsEvent>(_onCreateJobs);

  }

  _onCreateUsers(CreateUsEvent event, Emitter<UsersStateB> emit) async {
    emit(state.copyWidth(isLoading: true)); // imitacia zagruzki
    await Future.delayed(Duration(seconds: 1));
    final users = List.generate(
        event.count,
        (index) =>
            User(id: index.toString(), name: 'user name ' + index.toString()));
    emit(state.copyWidth(users: users));
  }
  _onCreateJobs(CreateJobsEvent event, Emitter<UsersStateB> emit) async {
        emit(state.copyWidth(isLoading: true)); // imitacia zagruzki
    await Future.delayed(Duration(seconds: 1));
    final jobs = List.generate(
        event.count,
        (index) =>
            Job(id: index.toString(), name: 'job ' + index.toString()));
    emit(state.copyWidth(jobs: jobs));
  }
}
