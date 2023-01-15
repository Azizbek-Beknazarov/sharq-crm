import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  String id;
  String name;
  String phone;
  int dateOfSignUp;
  String? password;

  CustomerEntity(
      {required this.name,
      required this.phone,
      required this.id,
      required this.dateOfSignUp,
      this.password});

  @override
  List<Object?> get props => [id, name, phone, dateOfSignUp, password];
}
