part of 'video_bloc.dart';

abstract class VideoStates extends Equatable {
  const VideoStates();

  @override
  List<Object> get props => [];
}

class VideoInitialState extends VideoStates {}

class VideoLoadingState extends VideoStates {}

class VideoAddedState extends VideoStates {}
class VideoUpdateState extends VideoStates {}

class VideoLoadedState extends VideoStates {
  final List<VideoEntity> loaded;

  VideoLoadedState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}

class VideoLoadedForCustomerState extends VideoStates {
  final List<VideoEntity> loaded;

  VideoLoadedForCustomerState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}

class VideoErrorState extends VideoStates {
  final String message;

  const VideoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class VideoDeletedState extends VideoStates {}
