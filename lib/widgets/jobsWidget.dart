import 'package:b_l/bloc-f/users-bloc/users-state-b.dart';
import 'package:b_l/bloc-f/users-bloc/users-worcker-b.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Jobs extends StatelessWidget {
  // final BuildContext context;
  final UserBlocWorcker usersBloc;
  Jobs({Key? key, 
  // required this.context
  required this.usersBloc
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final blocFromContextBad = BlocProvider.of<UserBlocWorcker>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('jobs data'),
      ),
      body: BlocBuilder<UserBlocWorcker, UsersStateB>(
          bloc: usersBloc,
          builder: (context, usersSt) {
            final jobs = usersSt.jobs;
            return Column(
              children: [
                if (usersSt.isLoading) CircularProgressIndicator(),
                // if (users.isNotEmpty)
                //   ...users.map((elem) => Text(elem.name)),
                if (jobs.isNotEmpty) ...jobs.map((elem) => Text(elem.name)),
              ],
            );
          }),
    );
  }
}
