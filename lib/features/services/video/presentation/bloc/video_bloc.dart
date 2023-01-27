import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';

import '../../domain/entity/video_entity.dart';
import '../../domain/usecase/delete_video_usecase.dart';
import '../../domain/usecase/get_video_for_customer_usecase.dart';
import '../../domain/usecase/get_video_usecase.dart';
import '../../domain/usecase/update_video_usecase.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvents, VideoStates> {
  final DeleteVideoClubUsecase _deleteVideoClubUsecase;
  final GetVideoForCustomerUseCase _getVideoForCustomerUseCase;
  final GetVideoUseCase _getVideoUseCase;
  final AddVideoUseCase _addVideoUseCase;

  VideoBloc(this._addVideoUseCase, this._deleteVideoClubUsecase,
      this._getVideoUseCase, this._getVideoForCustomerUseCase)
      : super(VideoInitialState()) {
    //1
    on<VideoGetEvent>((event, emit) async {
      if (event is VideoGetEvent) {
        emit(VideoLoadingState());
        final failOrVideo = await _getVideoUseCase.call(NoParams());
        failOrVideo.fold((l) => emit(VideoErrorState(message: l.toString())),
            (video) => emit(VideoLoadedState(loaded: video)));
      }
    });

    //2
    on<VideoAddEvent>((event, emit) async {
      if (event is VideoAddEvent) {
        emit(VideoLoadingState());

        await _addVideoUseCase
            .call(params: VideoParams(event.addEvent, event.customerId))
            .then((value) => emit(VideoAddedState()))
            .catchError((error) => emit(VideoErrorState(message: error)));
      }
    });
    //3
    on<VideoGetForCustomerEvent>((event, emit) async {
      if (event is VideoGetForCustomerEvent) {
        emit(VideoLoadingState());
        final failOrVideo = await _getVideoForCustomerUseCase
            .call(VideoGetParams(customerId: event.customerId));
        failOrVideo.fold((l) => emit(VideoErrorState(message: l.toString())),
            (video) => emit(VideoLoadedForCustomerState(loaded: video)));
      }
    });
    //4
    on<VideoDeleteEvent>((event, emit) async {
      if (event is VideoDeleteEvent) {
        emit(VideoLoadingState());
        await _deleteVideoClubUsecase
            .call(
                params: VideoDeleteParams(
                    customerId: event.customerId, videoID: event.videoId))
            .then((value) => emit(VideoDeletedState()))
            .catchError((error) => emit(VideoErrorState(message: error)));
      }
    });

    //
  }
}
