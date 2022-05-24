part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{}

class SearchResultListState<T> extends SearchState {
  final List<T> results;

  SearchResultListState(this.results);

  @override
  List<Object?> get props => [results];
}

class SearchErrorEventState extends SearchState {
  final String message;

  SearchErrorEventState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchLoadingState extends SearchState {

  SearchLoadingState();

  @override
  List<Object?> get props => [];


}