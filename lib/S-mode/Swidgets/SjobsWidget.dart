import 'package:b_l/S-mode/Sbloc-f/Susers-bloc/Susers-state-b.dart';
import 'package:b_l/S-mode/Sbloc-f/Susers-bloc/Susers-worcker-b.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Jobs extends StatelessWidget {
  // final BuildContext context;
  // final UserBlocWorcker usersBloc;
  const Jobs({
    super.key,
    // required this.context
    // required this.usersBloc
  });
  @override
  Widget build(BuildContext context) {
    // final blocFromContextBad = BlocProvider.of<UserBlocWorcker>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('jobs data'),
      ),
      body: BlocBuilder<UserBlocWorcker, UsersStateB>(
          // bloc: usersBloc,
          builder: (context, usersSt) {
        final jobs = usersSt.jobs;
        return Center(
          child: Column(
            children: [
              if (usersSt.isLoading) CircularProgressIndicator(),
              if (jobs.isNotEmpty) ...jobs.map((elem) => Text(elem.name)),
            ],
          ),
        );
      }),
    );
  }
}
