import 'package:b_l/bloc-f/bloc-counter.dart';
import 'package:b_l/bloc-f/users-bloc/users-event-b.dart';
import 'package:b_l/bloc-f/users-bloc/users-state-b.dart';
import 'package:b_l/bloc-f/users-bloc/users-worcker-b.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//raznie metody obnovleniya ui
// context .read / .watch / .select
// more demonstration, may be no worcked all ui logick

void main() {
  runApp(BlocDemo());
}

// MultBlocProvider vverhy, poluchaem bloci na nizhnem urovne
class BlocDemo extends StatelessWidget {
  const BlocDemo({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      home: WrapperBuilderWidget(),
    );
  }
}

class WrapperBuilderWidget extends StatelessWidget {
  // WrapperBuilderWidget({key? key}) :super(key: key); ?? question dyha
  WrapperBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CounterBlocWorcker>(
          create: (context) => CounterBlocWorcker()..add(BlocPlusEvent())),
      BlocProvider<UserBlocWorcker>(create: (context) => UserBlocWorcker()),
    ], child: MyBlocWidget());
  }
}

class MyBlocWidget extends StatelessWidget {
  const MyBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final counterBloc = CounterBlocWorcker()..add(BlocPlusEvent());
    // final usersBloc = UserBlocWorcker();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc lesson'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {

                final counterBloc =
                    BlocProvider.of<CounterBlocWorcker>(context);

                counterBloc.add(BlocPlusEvent());
              },
              icon: Icon(Icons.plus_one)),
          IconButton(
              onPressed: () {
                // poluchit counterBloc cherez blocProvider
                final counterBloc =
                    BlocProvider.of<CounterBlocWorcker>(context);
                counterBloc.add(BlocMinusEvent());
              },
              icon: Icon(Icons.exposure_neg_1_outlined)),
          IconButton(
              onPressed: () {
                // usersBloc.add(CreateUsEvent(counterBloc.state));
              },
              icon: Icon(Icons.person_2)),
          IconButton(
              onPressed: () {
                // usersBloc.add(CreateJobsEvent(counterBloc.state));
              },
              icon: Icon(Icons.work_outline))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<CounterBlocWorcker, int>(
                // bloc: counterBloc,

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
                    if (jobs.isNotEmpty) ...jobs.map((elem) => Text(elem.name)),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
