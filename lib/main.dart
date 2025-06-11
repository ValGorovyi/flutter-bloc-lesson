import 'package:b_l/bloc-f/bloc-counter.dart';
import 'package:b_l/bloc-f/users-bloc/users-event-b.dart';
import 'package:b_l/bloc-f/users-bloc/users-state-b.dart';
import 'package:b_l/bloc-f/users-bloc/users-worcker-b.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocDemo());
}

class BlocDemo extends StatelessWidget {
  const BlocDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      home: MyBlocWidget(),
    );
  }
}

class MyBlocWidget extends StatelessWidget {
  const MyBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBlocWorcker()..add(BlocPlusEvent());
    final usersBloc = UserBlocWorcker();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBlocWorcker>(create: (context) => counterBloc),
        BlocProvider<UserBlocWorcker>(create: (context) => usersBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bloc lesson'),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  counterBloc.add(BlocPlusEvent());
                },
                icon: Icon(Icons.plus_one)),
            IconButton(
                onPressed: () {
                  counterBloc.add(BlocMinusEvent());
                },
                icon: Icon(Icons.exposure_neg_1_outlined)),
            IconButton(
                onPressed: () {
                  usersBloc.add(CreateUsEvent(counterBloc.state));
                },
                icon: Icon(Icons.person_2)),
            IconButton(
                onPressed: () {
                  usersBloc.add(CreateJobsEvent(counterBloc.state));
                },
                icon: Icon(Icons.work_outline))
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                BlocBuilder<CounterBlocWorcker, int>(
                  bloc: counterBloc,
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: TextStyle(fontSize: 36),
                    );
                  },
                ),
                BlocBuilder<UserBlocWorcker, UsersStateB>(
                    builder: (context, usersSt) {
                  final users = usersSt.users;
                  final jobs = usersSt.jobs;
                  return Column(
                    children: [
                      if (usersSt.isLoading) CircularProgressIndicator(),
                      if (users.isNotEmpty)
                        ...users.map((elem) => Text(elem.name)),
                      if (jobs.isNotEmpty) 
                        ...jobs.map((elem) => Text(elem.name)),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
