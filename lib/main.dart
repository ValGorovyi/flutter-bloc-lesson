import 'package:b_l/bloc-f/bloc-file.dart';
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
      home: BlocWidget(),
    );
  }
}

class BlocWidget extends StatelessWidget {
  BlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocWorcker()..add(BlocPlusEvent());
    return BlocProvider<BlocWorcker>(
      //add event on started
      create: (conrext) => bloc,
      child:              Scaffold(
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        bloc.add(BlocPlusEvent());
                      },
                      icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        bloc.add(BlocMinusEvent());
                      },
                      icon: Icon(Icons.minimize))
                ],
              ),
              body: Center(
                child: BlocBuilder<BlocWorcker, int>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: TextStyle(fontSize: 36),
                    );
                  },
                ),
              ),
    ));
  }
}
