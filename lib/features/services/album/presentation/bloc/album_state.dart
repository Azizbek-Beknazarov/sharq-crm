part of 'album_bloc.dart';

abstract class AlbumStates extends Equatable {
  const AlbumStates();

  @override
  List<Object> get props => [];
}

class AlbumInitialState extends AlbumStates {}

class AlbumLoadingState extends AlbumStates {}

class AlbumAddedState extends AlbumStates {}
class AlbumUpdatedState extends AlbumStates {}

class AlbumLoadedState extends AlbumStates {
  final List<AlbumEntity> loaded;

  AlbumLoadedState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}

class AlbumLoadedForCustomerState extends AlbumStates {
  final List<AlbumEntity> loaded;

  AlbumLoadedForCustomerState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}

class AlbumErrorState extends AlbumStates {
  final String message;

  const AlbumErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AlbumDeletedState extends AlbumStates {}
class AlbumLoadedDateState extends AlbumStates {
  List<AlbumEntity> albumDateTimelist;
  AlbumLoadedDateState(this.albumDateTimelist);
}
