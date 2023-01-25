import 'package:equatable/equatable.dart';

class ClubEntity extends Equatable {
  String club_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  int fromHour;
  int toHour;
  String description;

  ClubEntity({
    required this.club_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.fromHour,
    required this.ordersNumber,
    required this.toHour,
    required this.description,
  });

  @override
  List<Object?> get props => [
        club_id,
        price,
        dateTimeOfWedding,
        ordersNumber,
        fromHour,
        toHour,
        description,
      ];
}
