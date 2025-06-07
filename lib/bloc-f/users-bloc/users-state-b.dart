abstract class UsersStateB {}

class InitialUserState extends UsersStateB {}

class UserLoadedState extends UsersStateB {
  final List<User> users;
  UserLoadedState(this.users);
}

class User {
  final String name;
  final String id;
  User({required this.id, required this.name});
}

class UserLoadingState extends UsersStateB {}
