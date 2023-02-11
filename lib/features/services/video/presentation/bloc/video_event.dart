part of 'video_bloc.dart';

abstract class VideoEvents extends Equatable {
  const VideoEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

//1
class VideoGetEvent extends VideoEvents {
  List<VideoEntity> list;

  VideoGetEvent(this.list);
}

//2
class VideoAddEvent extends VideoEvents {
  final VideoEntity addEvent;
  final String customerId;

  VideoAddEvent({required this.addEvent, required this.customerId})
      : super([addEvent, customerId]);
}

//3
class VideoGetForCustomerEvent extends VideoEvents {
  String customerId;

  VideoGetForCustomerEvent(this.customerId);
}

//4
class VideoDeleteEvent extends VideoEvents {
  final String customerId;
  final String videoId;

  VideoDeleteEvent({required this.customerId, required this.videoId})
      : super([customerId, videoId]);
}
//5
class VideoUpdateEvent extends VideoEvents {

  final String customerId;
  final String videoId;

  VideoUpdateEvent({required this.videoId, required this.customerId})
      : super([videoId, customerId]);
}
//6
class VideoStudioGetDateTimeOrdersEvent extends VideoEvents{
  final DateTime dateTime;
  VideoStudioGetDateTimeOrdersEvent({required this.dateTime}):super([dateTime]);
}

