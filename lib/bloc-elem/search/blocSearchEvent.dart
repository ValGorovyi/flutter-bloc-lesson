
class SearchBlocEvent {

}
class SearchGetUserEvent extends SearchBlocEvent {
  final String query;
  SearchGetUserEvent(this.query);
}