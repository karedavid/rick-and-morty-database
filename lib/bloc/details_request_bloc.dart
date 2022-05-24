import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_database/data/api_connection.dart';
import 'package:rick_and_morty_database/data/data_model.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'details_request_event.dart';
part 'details_request_state.dart';

class DetailsBloc extends Bloc<DetailsRequestEvent, DetailsRequestState> {

  DetailsBloc() : super(LocationInfoInitialState()) {
    on<LocationInfoRequestEvent>(
          (event, emit) async {
        try {
          emit(DetailsRequestLoadingState());
          var location = await apiConnection.getLocation(locationId: event.locationId);
          if(location == null){
            emit(DetailsRequestErrorState("Info request failed"));
          }else{
            emit(LocationInfoResultState(location));
          }
        } catch (e) {
          emit(DetailsRequestErrorState(e.toString()));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );

    on<EpisodeInfoRequestEvent>(
          (event, emit) async {
        try {
          emit(DetailsRequestLoadingState());
          var episode = await apiConnection.getEpisode(episodeId: event.episodeId);
          if(episode == null){
            emit(DetailsRequestErrorState("Info request failed"));
          }else{
            emit(EpisodeInfoResultState(episode));
          }
        } catch (e) {
          emit(DetailsRequestErrorState(e.toString()));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );
  }

}