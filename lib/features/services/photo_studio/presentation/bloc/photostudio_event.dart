import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

abstract class PhotoStudioEvents extends Equatable{
  const PhotoStudioEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];

}
class PhotoStudioGetEvent extends PhotoStudioEvents{
  List<PhotoStudioEntity> list;
  PhotoStudioGetEvent(this.list);
}
class PhotoStudioAddEvent extends PhotoStudioEvents{
final  PhotoStudioEntity addEvent;
final String customerId;

  PhotoStudioAddEvent({required this.addEvent,required this.customerId}):super([addEvent,customerId]);
}