import 'package:b_l/S-mode/Sbloc-f/Sbloc-counter.dart';
import 'package:b_l/S-mode/Sbloc-f/Susers-bloc/Susers-event-b.dart';
import 'package:b_l/S-mode/Sbloc-f/Susers-bloc/Susers-worcker-b.dart';
import 'package:b_l/S-mode/Swidgets/SjobsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocDemo());
}

class BlocDemo extends StatelessWidget {
  const BlocDemo({super.key});
  @override
  Widget build(BuildContext context) {
    // mozno obernut vse v muultiBlocProvider
    final counterBloc = CounterBlocWorcker();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBlocWorcker>(
          create: (context) => counterBloc,
          // lazy - kogda budet proishodit sozdanie. true - pri zagruzke konkretnoi stranicy, false - pri starte prilozheniya
          lazy: false,
        ),
        BlocProvider<UserBlocWorcker>(
            create: (context) => UserBlocWorcker(counterBloc)),
      ],
      child: MaterialApp(
        title: 'Bloc Demo',
        home: MyBlocWidget(),
      ),
    );
  }
}

//bloc listen other bloc. bad practick. but may be

class MyBlocWidget extends StatelessWidget {
  const MyBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final counterBloc = CounterBlocWorcker()..add(BlocPlusEvent());
    // final usersBloc = UserBlocWorcker();

    return
        //  MultiBlocProvider(
        // providers: [
        //   BlocProvider<CounterBlocWorcker>(create: (context) => counterBloc),
        //   BlocProvider<UserBlocWorcker>(
        //       create: (context) => UserBlocWorcker(counterBloc)),
        // ],
        // obertka Builder dla polucheniya bloca cherez context
        Builder(builder: (context) {
// esli na etom urovne napisat counter watch, to rerender vsego i kazhdiy raz. dazhe knopok iconButton

      // final counterBl = context.watch<CounterBlocWorcker>(); // its bad

      //norm - ispolzovat BlocProvider.of<>(context). adekvatniy rerender
      final counterBloc = BlocProvider.of<CounterBlocWorcker>(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Bloc lesson'),
        ),
        // BlocListener pozvolavet sledit za kakim-to state
        // BlocListener<blocZaKotorimSledim, stateType>

        //BlocCostumes tozhe daet listener. + builder(dostup k kontextu, dostup k state) {...}
        floatingActionButton: BlocConsumer<CounterBlocWorcker, int>(
          listenWhen: (previousState, currentState) =>
              previousState >
              currentState, //listenWhen - opredelit kogda proverka bydet proishodit
          listener: (context, state) {
            if (state == 0) {
              //proverka proishodit kazhdiy raz
              Scaffold.of(context).showBottomSheet((context) {
                return Container(
                  width: double.infinity,
                  height: 35,
                  color: Colors.yellow,
                  child: Text('now counter state is 0 >> $state'),
                );
              });
            }
          },
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(state.toString()),
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
                    //samoe plohoe reshenie - tupo peredat context.

                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Jobs()));

                    usersBloc.add(CreateJobsEvent(
                        context.read<CounterBlocWorcker>().state));
                  },
                  icon: Icon(Icons.work_outline))
            ],
          ),
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
                    final usersFromSelect =
                        context.select((UserBlocWorcker us) => us.state.users);
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
                // // bloc rabotaet korektno pri takom vizove
                // // scafold(scafold(...)) - nelza.
                // Jobs(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
