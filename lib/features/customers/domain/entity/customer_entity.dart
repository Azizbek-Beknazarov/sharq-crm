import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  String customerId;
  String name;
  String phone;
  int dateOfSignUp;
  bool managerAdded;

  CustomerEntity({
    required this.name,
    required this.phone,
    required this.customerId,
    required this.dateOfSignUp,
    required this.managerAdded
  });

  @override
  List<Object?> get props => [
    customerId,
        name,
        phone,
    managerAdded,
    dateOfSignUp,
      ];
}
