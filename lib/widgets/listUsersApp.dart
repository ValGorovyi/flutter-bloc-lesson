import 'package:b_l/bloc-elem/blocSearchW.dart';
import 'package:b_l/bloc-elem/search/blocSearchEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_user_repo/search_user_repo.dart';

class ListUsersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SearchUserRepo(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<SearchBlocW>(
                create: (context) => SearchBlocW(
                    searchUserRepo:
                        RepositoryProvider.of<SearchUserRepo>(context))),
          ],
          child: MaterialApp(
            theme: ThemeData(
                textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 35),
              bodySmall: TextStyle(fontSize: 25),
            )),
            home: AppLevel(),
          )),
    );
  }
}

class AppLevel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = context.select((SearchBlocW bloc) => bloc.state.users);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text('Searsch users'),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Input for user name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SearchBlocW>().add(SearchGetUserEvent(value));
            },
          ),
          if (users.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].username ?? 'Guest WithOut Name'),
                );
              },
              itemCount: users.length,
            ))
        ],
      )),
    );
  }
}
