part of 'album_bloc.dart';

abstract class AlbumEvents extends Equatable {
  const AlbumEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

//1
class AlbumGetEvent extends AlbumEvents {
  List<AlbumEntity> list;

  AlbumGetEvent(this.list);
}

//2
class AlbumAddEvent extends AlbumEvents {
  final AlbumEntity addEvent;
  final String customerId;

  AlbumAddEvent({required this.addEvent, required this.customerId})
      : super([addEvent, customerId]);
}

//3
class AlbumGetForCustomerEvent extends AlbumEvents {
  String customerId;

  AlbumGetForCustomerEvent(this.customerId);
}

//4
class AlbumDeleteEvent extends AlbumEvents {
  final String customerId;
  final String albumId;

  AlbumDeleteEvent({required this.customerId, required this.albumId})
      : super([customerId, albumId]);
}
//5
class AlbumUpdateEvent extends AlbumEvents {

  final String customerId;
  final String albumId;

  AlbumUpdateEvent({required this.albumId, required this.customerId})
      : super([albumId, customerId]);
}
//6
class AlbumStudioGetDateTimeOrdersEvent extends AlbumEvents{
  final DateTime dateTime;
  AlbumStudioGetDateTimeOrdersEvent({required this.dateTime}):super([dateTime]);
}

