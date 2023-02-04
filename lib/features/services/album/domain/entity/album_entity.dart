import 'package:equatable/equatable.dart';

class AlbumEntity extends Equatable {
  String album_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  String description;
  String address;
  bool isPaid;

  AlbumEntity({
    required this.album_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.ordersNumber,
    required this.description,
    required this.address,
    required this.isPaid,
  });

  @override
  List<Object?> get props => [
        album_id,
        price,
        dateTimeOfWedding,
        ordersNumber,
        description,
    address,
    isPaid
      ];
}
