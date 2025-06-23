import 'dart:async';

import 'package:b_l/bloc-f/bloc-counter.dart';
import 'package:b_l/bloc-f/users-bloc/users-event-b.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users-state-b.dart';

class UserBlocWorcker extends Bloc<UsersEventB, UsersStateB> {

  //bloc v drugoi bloc - plohaya practika. no inogda delayut tak
  //slushayet count i pri <= 0 obnovit kolichestvo user, job v 0

  // peredat v constructor
  final CounterBlocWorcker counterBlocW;
  //late - bydet opisana pozhe
  late final StreamSubscription counterBlocStream;

  UserBlocWorcker(this.counterBlocW) : super(UsersStateB()) {
    on<CreateUsEvent>(_onCreateUsers);
    on<CreateJobsEvent>(_onCreateJobs);

    //opredilayem counterBlocStr
    counterBlocStream = counterBlocW.stream.listen((streamData) {
      // streamData - state. to, chto onslezhivaetsa v tom bloce 
      if(streamData <= 0) {
        // vizov sobitoya, dobavlenie
        add(CreateUsEvent(0));
        add(CreateJobsEvent(0));
      }
    });

  }
  @override
  Future<void> close() {
    counterBlocStream.cancel();
    return super.close();
  }

  _onCreateUsers(CreateUsEvent event, Emitter<UsersStateB> emit) async {
    emit(state.copyWidth(isLoading: true)); // imitacia zagruzki
    await Future.delayed(Duration(seconds: 1));
    final users = List.generate(
        event.count,
        (index) =>
            User(id: index.toString(), name: 'user name $index'));
    emit(state.copyWidth(users: users));
  }
  _onCreateJobs(CreateJobsEvent event, Emitter<UsersStateB> emit) async {
        emit(state.copyWidth(isLoading: true)); // imitacia zagruzki
    await Future.delayed(Duration(seconds: 1));
    final jobs = List.generate(
        event.count,
        (index) =>
            Job(id: index.toString(), name: 'job $index'));
    emit(state.copyWidth(jobs: jobs));
  }
}
