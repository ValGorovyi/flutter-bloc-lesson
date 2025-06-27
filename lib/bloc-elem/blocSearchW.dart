

import 'package:b_l/bloc-elem/search/blocSearchEvent.dart';
import 'package:b_l/bloc-elem/search/blocSearchState.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const apiUrl = 'https://api.jikan.moe/v4/users';

EventTransformer<E> debounceDropable<E> (Duration duration){
  return (event, mapper) {
    return droppable<E>().call(event.debounce(duration), mapper);
  };
}

class SearchBlocW extends Bloc<SearchBlocEvent, SearchBlocState>{

  final _httpClient = Dio();

  SearchBlocW() : super(SearchBlocState()) {
    on<SearchGetUserEvent>(_onSearch);
  }

  _onSearch(SearchGetUserEvent event, Emitter<SearchBlocState> emit) async {
    if (event.query.length < 3) {
      return;
    }
    final resultGetUsers = await _httpClient.get(apiUrl, queryParameters: {
      'q': event.query
    });
    emit(SearchBlocState(users: resultGetUsers.data['data']));
  }
}
