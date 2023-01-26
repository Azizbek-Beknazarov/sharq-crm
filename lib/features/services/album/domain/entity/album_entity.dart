import 'package:equatable/equatable.dart';

class AlbumEntity extends Equatable {
  String album_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  String description;

  AlbumEntity({
    required this.album_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.ordersNumber,
    required this.description,
  });

  @override
  List<Object?> get props => [
        album_id,
        price,
        dateTimeOfWedding,
        ordersNumber,
        description,
      ];
}
