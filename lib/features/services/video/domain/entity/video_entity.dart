import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  String video_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  String description;

  VideoEntity({
    required this.video_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.ordersNumber,
      required this.description,
  });

  @override
  List<Object?>   get props => [
        video_id,
        price,
        dateTimeOfWedding,
        ordersNumber,
        description,
      ];
}
