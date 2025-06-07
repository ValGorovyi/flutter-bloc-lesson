abstract class UsersEventB {}

class CreateUsEvent extends UsersEventB {
  final int count;
  CreateUsEvent(this.count);
}
