part of 'club_bloc.dart';

abstract class ClubEvents extends Equatable {
  const ClubEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

//1
class ClubGetEvent extends ClubEvents {
  List<ClubEntity> list;

  ClubGetEvent(this.list);
}

//2
class ClubAddEvent extends ClubEvents {
  final ClubEntity addEvent;
  final String customerId;

  ClubAddEvent({required this.addEvent, required this.customerId})
      : super([addEvent, customerId]);
}

//3
class ClubGetForCustomerEvent extends ClubEvents {
  String customerId;

  ClubGetForCustomerEvent(this.customerId);
}

//4
class ClubDeleteEvent extends ClubEvents {
  final String customerId;
  final String clubId;

  ClubDeleteEvent(
      {required this.customerId, required this.clubId})
      : super([customerId, clubId]);
}
//5
class ClubUpdateEvent extends ClubEvents {

  final String customerId;
  final String clubId;

  ClubUpdateEvent({required this.clubId, required this.customerId})
      : super([clubId, customerId]);
}
