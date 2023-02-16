
part of 'club_bloc.dart';
abstract class ClubStates extends Equatable {
  const ClubStates();

  @override
  List<Object> get props => [];
}

class ClubInitialState extends ClubStates {}

class ClubLoadingState extends ClubStates {}

class ClubAddedState extends ClubStates {}
class ClubUpdatedState extends ClubStates {}

class ClubLoadedState extends ClubStates {
  final List<ClubEntity> loaded;

  ClubLoadedState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}
class ClubLoadedForCustomerState extends ClubStates {
  final List<ClubEntity> loaded;

  ClubLoadedForCustomerState({required this.loaded});

  @override
  List<Object> get props => [loaded];
}


class ClubErrorState extends ClubStates{
  final String message;

  const ClubErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
class ClubDeletedState extends ClubStates {}
class ClubLoadedDateState extends ClubStates {
  List<ClubEntity> clubDateTimelist;
  ClubLoadedDateState(this.clubDateTimelist);
}