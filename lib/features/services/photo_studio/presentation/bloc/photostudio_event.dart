import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

abstract class PhotoStudioEvents extends Equatable {
  const PhotoStudioEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

//1
class PhotoStudioGetEvent extends PhotoStudioEvents {
  List<PhotoStudioEntity> list;

  PhotoStudioGetEvent(this.list);
}

//2
class PhotoStudioAddEvent extends PhotoStudioEvents {
  final PhotoStudioEntity addEvent;
  final String customerId;

  PhotoStudioAddEvent({required this.addEvent, required this.customerId})
      : super([addEvent, customerId]);
}

//3
class PhotoStudioGetForCustomerEvent extends PhotoStudioEvents {
  // List<PhotoStudioEntity> list;
  String customerId;

  PhotoStudioGetForCustomerEvent(this.customerId);
}

//4
class PhotoStudioDeleteEvent extends PhotoStudioEvents {
  final String customerId;
  final String photoStudioId;

  PhotoStudioDeleteEvent(
      {required this.customerId, required this.photoStudioId})
      : super([customerId, photoStudioId]);
}
//5
class PhotoStudioUpdateEvent extends PhotoStudioEvents {

  final String customerId;
  final String photostudioId;

  PhotoStudioUpdateEvent({required this.photostudioId, required this.customerId})
      : super([photostudioId, customerId]);
}

//6
class PhotoStudioGetDateTimeOrdersEvent extends PhotoStudioEvents{
  final DateTime dateTime;
  PhotoStudioGetDateTimeOrdersEvent({required this.dateTime}):super([dateTime]);
}
