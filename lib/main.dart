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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      home: MyBlocWidget(),
    );
  }
}

//bloc listen other bloc. bad practick. but may be

class MyBlocWidget extends StatelessWidget {
  const MyBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBlocWorcker()..add(BlocPlusEvent());
    // final usersBloc = UserBlocWorcker();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBlocWorcker>(
            create: (context) => counterBloc),
        BlocProvider<UserBlocWorcker>(create: (context) => UserBlocWorcker(counterBloc)),
      ],
      // obertka Builder dla polucheniya bloca cherez context
      child: Builder(builder: (context) {
// esli na etom urovne napisat counter watch, to rerender vsego i kazhdiy raz. dazhe knopok iconButton

        // final counterBl = context.watch<CounterBlocWorcker>(); // its bad

        //norm - ispolzovat BlocProvider.of<>(context). adekvatniy rerender
        final counterBloc = BlocProvider.of<CounterBlocWorcker>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Bloc lesson'),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    // without needed context
                    // dla dobavleniya kontexta - obernut vse pod MultiBlocProvider v Builder
                    // final counterBloc = context.read<CounterBlocWorcker>();
                    // demo

                    // counterBl.add(BlocPlusEvent());
                    counterBloc.add(BlocPlusEvent());
                  },
                  icon: Icon(Icons.plus_one)),
              IconButton(
                  onPressed: () {
                    // poluchit counterBloc cherez blocProvider
                    // final counterBloc = context.read<CounterBlocWorcker>();
                    counterBloc.add(BlocMinusEvent());
                  },
                  icon: Icon(Icons.exposure_neg_1_outlined)),
              IconButton(
                  onPressed: () {
                    final usersBloc = context.read<UserBlocWorcker>();
                    usersBloc.add(CreateUsEvent(
                        context.read<CounterBlocWorcker>().state));
                  },
                  icon: Icon(Icons.person_2)),
              IconButton(
                  onPressed: () {
                    final usersBloc = context.read<UserBlocWorcker>();

                    usersBloc.add(CreateJobsEvent(
                        context.read<CounterBlocWorcker>().state));
                  },
                  icon: Icon(Icons.work_outline))
            ],
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  BlocBuilder<CounterBlocWorcker, int>(
                    // buildWhen: (prev, next) {},
                    builder: (context, state) {
// naprimer nado vivodit ne tolko counter, no i users

//poluchaem users iz select
                      final usersFromSelect = context
                          .select((UserBlocWorcker us) => us.state.users);
                      return Column(
                        children: [
                          Text(
                            state.toString(),
                            style: TextStyle(fontSize: 36),
                          ),
                          // cherez context.read ne srabotaet. demo version
                          if (usersFromSelect.isNotEmpty)
                            ...usersFromSelect.map((u) => Text(u.name))
                        ],
                      );
                    },
                  ),
                  BlocBuilder<UserBlocWorcker, UsersStateB>(
                      builder: (context, usersSt) {
                    // final users = usersSt.users;
                    final jobs = usersSt.jobs;
                    return Column(
                      children: [
                        if (usersSt.isLoading) CircularProgressIndicator(),
                        // if (users.isNotEmpty)
                        //   ...users.map((elem) => Text(elem.name)),
                        if (jobs.isNotEmpty)
                          ...jobs.map((elem) => Text(elem.name)),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
