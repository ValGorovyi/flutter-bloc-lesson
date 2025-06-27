abstract class UsersEventB {}

class CreateUsEvent extends UsersEventB {
  final int count;
  CreateUsEvent(this.count);
}
class CreateJobsEvent extends UsersEventB {
  final int count;
  CreateJobsEvent(this.count);
}