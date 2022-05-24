import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_database/data/api_connection.dart';
import 'package:rick_and_morty_database/data/data_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchBloc() : super(SearchResultListState(const [])) {
    on<SearchUpdateCharacterEvent>(
          (event, emit) async {
        try {
          emit(SearchLoadingState());
          var searchResult = await apiConnection.searchCharacter(searchTerm: event.filterTerm);
          emit(SearchResultListState<Character>(searchResult));
        } catch (e) {
          emit(SearchErrorEventState(e.toString()));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );

    on<SearchUpdateLocationEvent>(
          (event, emit) async {
        try {
          emit(SearchLoadingState());
          var searchResult = await apiConnection.searchLocation(searchTerm: event.filterTerm);
          emit(SearchResultListState<Location>(searchResult));
        } catch (e) {
          emit(SearchErrorEventState(e.toString()));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );

    on<SearchUpdateEpisodeEvent>(
          (event, emit) async {
        try {
          emit(SearchLoadingState());
          var searchResult = await apiConnection.searchEpisode(searchTerm: event.filterTerm);
          emit(SearchResultListState<Episode>(searchResult));
        } catch (e) {
          emit(SearchErrorEventState(e.toString()));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );
  }

}