part of 'details_request_bloc.dart';

@immutable
abstract class DetailsRequestEvent {}

class LocationInfoRequestEvent extends DetailsRequestEvent{
  final String locationId;
  LocationInfoRequestEvent(this.locationId);
}

class EpisodeInfoRequestEvent extends DetailsRequestEvent{
  final String episodeId;
  EpisodeInfoRequestEvent(this.episodeId);
}

