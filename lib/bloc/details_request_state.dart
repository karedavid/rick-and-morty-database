part of 'details_request_bloc.dart';

@immutable
abstract class DetailsRequestState extends Equatable{}

class LocationInfoInitialState extends DetailsRequestState {

  LocationInfoInitialState();

  @override
  List<Object?> get props => [null];
}

class LocationInfoResultState extends DetailsRequestState {
  final Location location;

  LocationInfoResultState(this.location);

  @override
  List<Object?> get props => [location];
}

class EpisodeInfoInitialState extends DetailsRequestState {

  EpisodeInfoInitialState();

  @override
  List<Object?> get props => [null];
}

class EpisodeInfoResultState extends DetailsRequestState {
  final Episode episode;

  EpisodeInfoResultState(this.episode);

  @override
  List<Object?> get props => [episode];
}

class DetailsRequestErrorState extends DetailsRequestState {
  final String error;

  DetailsRequestErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class DetailsRequestLoadingState extends DetailsRequestState {

  @override
  List<Object?> get props => [];

}