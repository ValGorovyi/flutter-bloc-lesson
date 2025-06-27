class UsersStateB {
  final List<User> users;
  final List<Job> jobs;
  final bool isLoading;

  UsersStateB({
    this.users = const [],
    this.jobs = const [],
    this.isLoading = false,
  });
  UsersStateB copyWidth(
      {List<User>? users, List<Job>? jobs, bool isLoading = false}) {
    return UsersStateB(
      users: users ?? this.users,
      jobs: jobs ?? this.jobs,
      isLoading: isLoading,
    );
  }
}

class Job {
  final String name;
  final String id;
  Job({required this.id, required this.name});
}

// class InitialUserState extends UsersStateB {}

// class UserLoadedState extends UsersStateB {
//   final List<User> users;
//   UserLoadedState(this.users);
// }

class User {
  final String name;
  final String id;
  User({required this.id, required this.name});
}

// class UserLoadingState extends UsersStateB {}
