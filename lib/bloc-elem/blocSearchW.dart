import 'package:search_user_repo/search_user_repo.dart';
import 'package:b_l/bloc-elem/search/blocSearchEvent.dart';
import 'package:b_l/bloc-elem/search/blocSearchState.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const apiUrl = 'https://api.jikan.moe/v4/users';

EventTransformer<E> debounceDropable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.debounce(duration), mapper);
  };
}

class SearchBlocW extends Bloc<SearchBlocEvent, SearchBlocState> {

  SearchBlocW({required SearchUserRepo searchUserRepo})
      : _searchUserRepo = searchUserRepo,
        super(SearchBlocState()) {
    on<SearchGetUserEvent>(_onSearch,
        transformer: debounceDropable(Duration(milliseconds: 305)));
  }
  late final SearchUserRepo _searchUserRepo;

  _onSearch(SearchGetUserEvent event, Emitter<SearchBlocState> emit) async {
    if (event.query.isEmpty) {
      return emit(SearchBlocState(users: []));
    }
    if (event.query.length < 3) {
      return;
    }
    final users = await _searchUserRepo.onSearch(event.query);
    emit(SearchBlocState(users: users));
  }
}
