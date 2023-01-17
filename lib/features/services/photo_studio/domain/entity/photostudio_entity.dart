import 'package:equatable/equatable.dart';

class PhotoStudioEntity extends Equatable {
  final String photo_studio_id;
  final int price;

  PhotoStudioEntity(this.photo_studio_id, this.price);

  @override
  List<Object?> get props => [photo_studio_id, price];
}
