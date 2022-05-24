part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchUpdateCharacterEvent extends SearchEvent{
  final String filterTerm;
  SearchUpdateCharacterEvent(this.filterTerm);
}

class SearchUpdateLocationEvent extends SearchEvent{
  final String filterTerm;
  SearchUpdateLocationEvent(this.filterTerm);
}

class SearchUpdateEpisodeEvent extends SearchEvent{
  final String filterTerm;
  SearchUpdateEpisodeEvent(this.filterTerm);
}