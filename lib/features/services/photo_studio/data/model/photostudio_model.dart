import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

class PhotoStudioModel extends PhotoStudioEntity {
  PhotoStudioModel({required String photo_studio_id, required int price})
      : super(photo_studio_id, price);

  factory PhotoStudioModel.fromJson(Map<String, dynamic> json) {
    return PhotoStudioModel(
        photo_studio_id: json['photo_studio_id'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return ({
      'photo_studio_id': photo_studio_id,
      'price': price,
    });
  }
}
