import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

abstract class PhotoStudioStates extends Equatable {
  const PhotoStudioStates();

  @override
  List<Object> get props => [];
}
class PhotoStudioInitialState extends PhotoStudioStates{}
class PhotoStudioLoadingState extends PhotoStudioStates{}
class PhotoStudioLoadedState extends PhotoStudioStates{
  final List<PhotoStudioEntity> loaded;

  PhotoStudioLoadedState({required this.loaded});
  @override
  List<Object> get props => [loaded];
}
class PhotoStudioErrorState extends PhotoStudioStates{
  final String message;

  const PhotoStudioErrorState({required this.message});

  @override
  List<Object> get props => [message];
}