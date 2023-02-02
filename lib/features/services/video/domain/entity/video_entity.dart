import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  String video_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  String description;
  String address;
  bool isPaid;

  VideoEntity({
    required this.video_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.ordersNumber,
    required this.description,
    required this.address,
    required this.isPaid,
  });

  @override
  List<Object?> get props => [
        video_id,
        address,
        price,
        dateTimeOfWedding,
        ordersNumber,
        description,
        isPaid,
      ];
}
