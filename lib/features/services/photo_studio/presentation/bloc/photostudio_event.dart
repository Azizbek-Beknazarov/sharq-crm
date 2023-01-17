import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

abstract class PhotoStudioEvents extends Equatable{
  PhotoStudioEvents();
  @override

  List<Object?> get props => [];

}
class PhotoStudioGetEvent extends PhotoStudioEvents{
  List<PhotoStudioEntity> list;
  PhotoStudioGetEvent(this.list);
}